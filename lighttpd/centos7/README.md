dockerfiles-centos-lighttpd
========================

CentOS 7 dockerfile for lighttpd (http://www.lighttpd.net/)

Configuration
-----

You should prepare SSH public key and copy it to cfg_files/lighttpd/.ssh/authorized_keys so you'll be able to login to the container (sshd config denies login to any
other user).

Installation
-----

Copy your SSH public key to authorized_keys:

    $ cat ~/.ssh/id_rsa.pub > cfg_files/lighttpd/.ssh/authorized_keys

Prepare directories for logs and configs and htdocs:

    $ mkdir /srv/docker_mounts/lighttpd/{logs,configs,htdocs} -p

If you have prepared lighttpd.conf you can put it now in
/srv/docker_mounts/lighttpd/configs (this dir will be mounted as 
/etc/lighttpd in the container). If not than the default will be generated and
used by lighttpd daemon.

Clone Dockerfile somewhere and build the container:

    $ sudo docker build -t lighttpd:centos7 --rm .

Take note of ssh lighttpd user password during above build process - you'll
need that later:

    Step 17 : RUN /root/scripts/init.sh
    ...
    lighttpd ssh password: YYYYYYYYY

And now run the container:

    On docker 1.0.0+:
    $ sudo docker run -d -p 8091:80/tcp -v /srv/docker_mounts/lighttpd/configs:/etc/lighttpd -v /srv/docker_mounts/lighttpd/logs:/var/log/lighttpd -v /srv/docker_mounts/lighttpd/htdocs/:/srv/httpd/htdocs --name=lighttpd -t lighttpd:centos7

In above example params means:

* -p 8091:80/tcp - let's forward external 8091 port from host to container
* ports 80
* -v /srv/docker_mounts/lighttpd/logs:/var/log/lighttpd:rw - mounting host
* /srv/.../logs dir in container's /var/log/lighttpd dir with rw rights

After running container it should be working fine and you should be able to ssh
to it using ssh key that you pasted before to cfg_files/lighttpd/.ssh/authorized_keys

Testing
-----

Just try accessing some webpage (did you generate and put any in the htdocs
dir?). First let's check container IP:

    $ sudo docker inspect -format '{{ .NetworkSettings.IPAddress }}' container_id

And next use use links:

    $ links http://@container_IP_ADDR/index.html

Also try to ssh to the container with lighttpd user:

    $ ssh lighttpd@container_IP

Seeing only 404 error? Probably you didn't put any index.html into htdocs dir.
Also remember that default lighttpd config expects htdocs/lighttpd as the
public directory so you should create e.g. htdocs/lighttpd/index.html file

Managing configuration:
-----

In order to change configuration just edit cfg files in host
/srv/docker_mounts/lighttpd/configs (remember that this dir is mounted on
/etc/lighttpd/ in container) and run a command:

    $ ssh lighttpd@container_IP "sudo /etc/init.d/lighttpd restart"

Managing logfiles
-----

You can access logfiles within host in /srv/docker_mounts/lighttpd/logs; those logs
are rotated by containers logrotate.
