# Openshift Ready Moodle Container

## Building the container:

To build this container yourself, please navigate this this directory after cloning and run:

    $ docker build -t moodle -f Dockerfile .

## Running the container (with postgresql backend):

First start postgresql container:

    $ docker run -e POSTGRESQL_USER=moodle -e POSTGRESQL_PASSWORD=moodle -e POSTGRESQL_DATABASE=moodle -d registry.centos.org/postgresql/postgresql:9.6

Now find the hostname or ip of postgresql container:

    $ docker run -e DB_TYPE=pgsql -e DB_HOST=<POSTGRES_IP> -d moodle
    
## Mount Points:

 1. /var/moodledata - This is where the moodle will store its caching data. Please ensure you mount a volume with appropriate permissions here.
 
## Environment Variables:

You can customize parts of moodle by passing certain values as environment variables when you run it.

 1. DB_TYPE - pgsql | mariadb | mysqli | mssql | sqlsrv | oci : The type of database to use. The terms are self explanatory, however oci for oracle is currently not supported due to licensing issues with their client software.
 2. DB_HOST - The hostname or ip of the database that moodle will use.
 3. DB_NAME - The name of the moodle database in the DB. This assumes the database has already been setup with appropriate users and permissions.
 4. DB_USER - The username of the user who has permissions on DB_NAME in DB_HOST. 
 5. DB_PASSWD - The password of DB_USER.
 6. MOODLE_URL - The URL of moodle endpoint. This should include the the protocol and port, if any (unless your URL is internally mapped to port 8080 of container as can be done with openshift routes). Default value will be http:\/\/containerip:8080. **Please ensure you escape any such slashes in your own hostname as it will be internally passed to a `sed` command to update the config.php. Its compulsory to either have http or https preceeding this URL.**

### Tracking Updates:

 1. **PHP** : PHP updates can be tracked in remicolt repository.
 2. **Moodle** : For moodle, we will have track releases on from download.moodle.org or even on release
    monitoring (https://release-monitoring.org/project/6384/)

### Notes:

 1. For users of selinux based systems, if you try to volume mount, you might have permission issues even if you do `-v /somepath:/var/moodledata:rw`. You can get more information about that [here](http://www.projectatomic.io/blog/2015/06/using-volumes-with-docker-can-cause-problems-with-selinux/ "SELinux with docker volumes").
