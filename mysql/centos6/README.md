![logo](https://www.mysql.com/common/logos/logo-mysql-170x115.png)

# What is MySQL?

MySQL is the world's most popular open source database. With its proven performance, reliability and ease-of-use, MySQL has become the leading database choice for web-based applications, covering the entire range from personal projects and websites, via online shops and information services, all the way to high profile web properties including Facebook, Twitter, YouTube, Yahoo! and many more.

For more information and related downloads for MySQL Server and other MySQL products, please visit <http://www.mysql.com>

# How to Use the Images

## Build a MySQL Server Image

```
docker build --rm=true -t mysql-server:5.1 .
```

## Start a MySQL Server Instance

Start a MySQL Server container as follows:

```
docker run --name container-name -e MYSQL_ROOT_PASSWORD=secret -d mysql-server:tag
```

Where `container-name` is the name you want to assign to your container, `secret` is the password to be set for the root user and `tag` is the tag specifying the version you want.

## Connect to MySQL Server from an Application in Another Docker Container

This image exposes the standard MySQL port (3306), so container linking makes the instance available to other containers. Start other containers like this in order to link it to the MySQL Server container:

```
docker run --name app-container-name --link container-name -d app-that-uses-mysql
```

## Connect to MySQL Server from the MySQL Command Line Client

The following command starts another container instance and runs the `mysql` command line client against your original container, allowing you to execute SQL statements against your database:

```
docker run -it --link container-name --rm mysql-server:tag mysql -h container-name -P 3306 -uroot -psecret'
```

where `container-name` is the name of your database container.

# Environment Variables

When you start a MySQL Server container, you can adjust the configuration of the instance by passing one or more environment variables on the `docker run` command line. Do note that none of the variables below will have any effect if you start the container with a data directory that already contains a database: any pre-existing database will always be left untouched on container startup.

Most of the variables listed below are optional, but one of the variables `MYSQL_ROOT_PASSWORD`, `MYSQL_ALLOW_EMPTY_PASSWORD`, `MYSQL_RANDOM_ROOT_PASSWORD` must be given.

## `MYSQL_ROOT_PASSWORD`

This variable specifies a password that will be set for the root superuser account. In the above example, it was set to `secret`. **NOTE:** Setting the MySQL root user password on the command line is insecure.

## `MYSQL_RANDOM_ROOT_PASSWORD`

When this variable is set to `yes`, a random password for the server's root user will be generated. The password will be printed to stdout in the container, and it can be obtained by using the command `docker logs container-name`.

## `MYSQL_DATABASE`

This variable is optional. It allows you to specify the name of a database to be created on image startup. If a user/password was supplied (see below) then that user will be granted superuser access (corresponding to GRANT ALL) to this database.

## `MYSQL_USER`, `MYSQL_PASSWORD`

These variables are optional, used in conjunction to create a new user and set that user's password. This user will be granted superuser permissions (see above) for the database specified by the `MYSQL_DATABASE` variable. Both variables are required for a user to be created.

Do note that there is no need to use this mechanism to create the `root` superuser, that user gets created by default with the password set by either of the mechanisms (given or generated) discussed above.

## `MYSQL_ALLOW_EMPTY_PASSWORD`

Set to `yes` to allow the container to be started with a blank password for the root user. **NOTE:** Setting this variable to `yes` is not recommended unless you really know what you are doing, since this will leave your instance completely unprotected, allowing anyone to gain complete superuser access.

# Notes, Tips, Gotchas

## Secure Container Startup

In many use cases, employing the `MYSQL_ROOT_PASSWORD` variable to specify the MySQL root user password on initial container startup is insecure. Instead, to keep your setup as secure as possible, we strongly recommend using the `MYSQL_RANDOM_ROOT_PASSWORD` option.

## Where to Store Data

There are many two ways to store data used by applications that run in Docker containers. We maintain our usual stance and encourage users to investigate the options and use the method that best suits their use case. Here are some of the options available:

- Let Docker manage the storage of your database data by writing the database files to disk on the host system using its own internal volume management. The current solutions, devicemapper, aufs and overlayfs have negative performance records.
- Create a data directory on the host system (outside the container on high performance storage) and mount this to a directory visible from inside the container. This places the database files in a known location on the host system, and makes it easy for tools and applications on the host system to access the files. The user needs to make sure that the directory exists, and that permissions and other security mechanisms on the host system are set up correctly.

The Docker documentation is a good starting point for understanding the different storage options and variations, and there are multiple blog and forum postings that discuss and give advice in this area. We will simply show the basic procedure here for the latter option above:

1. Create a data directory on a suitable volume on your host system, e.g. `/local/datadir`.
2. Start your container like this:

```
    docker run --name container-name -v /local/datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=secret -d mysql-server:tag
```

The `-v /local/datadir:/var/lib/mysql` part of the command mounts the `/local/datadir` directory from the underlying host system as `/var/lib/mysql` inside the container, where MySQL by default will write its data files.

Note that users on systems with SELinux enabled may experience problems with this. The current workaround is to assign the relevant SELinux policy type to the new data directory so that the container will be allowed to access it:

```
chcon -Rt svirt_sandbox_file_t /local/datadir
```

## Existing Data

If you start your MySQL container instance with a data directory that already contains a data (specifically, a `mysql` subdirectory where all our system tables live), the `$MYSQL_ROOT_PASSWORD` variable should be omitted from the `docker run` command.

## Port forwarding

Docker allows mapping of ports on the container to ports on the host system by using the -p option. If you start the container as follows, you can connect to the database by connecting your client to a port on the host machine. This can greatly simplfy consolidating many instances to a single host. In this example port 6603, the we use the address of the Docker host to connect to the TCP port the Docker deamon is forwarding from:

```
docker run --name container-name `-p 6603:3306` -d mysql-server:tag
mysql -h docker_host_ip -P 6603
```

## Passing options to the server

You can pass arbitrary command line options to the MySQL server by appending them to the `run command`:

```
docker run --name my-container-name -d mysql-server:tag --option1=value --option2=value
```

In this case, the values of option1 and option2 will be passed directly to the server when it is started. The following command will for instance start your container with UTF-8 as the default setting for character set and collation for all databases in MySQL:

```
docker run --name container-name -d mysql-server:tag --character-set-server=utf8 --collation-server=utf8_general_ci
```

## Using a Custom MySQL Server Config File

The MySQL Server startup configuration in these Docker images is specified in the file `/etc/my.cnf`. If you want to customize this configuration for your own purposes, you can create your alternative configuration file in a directory on the host machine and then mount this file in the appropriate location inside the MySQL Server container, effectively replacing the standard configuration file.

If you want to base your changes on the standard configuration file, start your MySQL Server container in the standard way described above, then do:

```
docker exec -it my-container-name cat /etc/my.cnf > /my/custom/config-file
```

... where `/my/custom/config-file` is the path and name of the new configuration file. Then start a new MySQL Server container like this:

```
docker run --name my-new-container-name -v /my/custom/config-file:/etc/my.cnf -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql-server:tag
```

This will start a new MySQL Server container `my-new-container-name` where the MySQL Server instance uses the startup options specified in `/my/custom/config-file`.

## Credits

Strongly inspired by:

- <https://github.com/docker-library/percona>
- <https://github.com/docker-library/docker-mysql>
