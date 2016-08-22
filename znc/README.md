ZNC Docker image
====================

This container image includes ZNC-1.6.3 for OpenShift and general usage.

Environment variables and volumes
----------------------------------

The following environment variable influence the ZNC configuration file (and optional)

|    Variable name      |    Description                   |    Default
| :-------------------- | -------------------------------- | -------------------------
|  `ZNC_ADMIN_PASSWORD` | Sets password for ZNC admin User |  admin

You can also set the following mount points by passing the `-v /host:/container` flag to Docker.

|  Volume mount point      | Description        |
| :----------------------- | ------------------ |
|  `/var/lib/znc-data`     | ZNC data directory |

**Notice: When mouting a directory from the host into the container, ensure that the mounted
directory has the appropriate permissions and that the owner and group of the directory
matches the user UID which is running inside the container.**

Usage
---------------------------------

For this, we will assume that you are using the `znc` image.
If you don't want to store the optional variable and data directory then execute the following command:

```
$ docker run -d --name znc -p 6667:6667 znc
```

This will create a container named `znc` running znc sever with `admin` as user
and `admin` credentials. Port 6667 will be exposed and mapped
to the host. If you want your ZNC to be persistent across container executions,
also add a `-v /host/znc/data:/var/lib/znc-data` argument. This will be the ZNC
data directory.


ZNC admin user
---------------------------------
The admin user has `admin` password set by default.
You can set it by setting the `ZNC_ADMIN_PASSWORD` environment variable.
