dockerfiles-centos-bind
========================

CentOS 6 dockerfile for Bind - based resolving & cache'ing (DNS server)

Configuration
-----

You should configure legit networks in cfg_files/named.conf in order to allow
those to query this DNS server. By default legit networks are 127.0.0.1 and
whole 172.16.0.0/12 private network (as Docker uses those ranges for internal
networking).

You should also prepare SSH public key and copy it to cfg_files/bindadm/.ssh/authorized_keys
so you'll be able to login to the container (sshd config denies login to any
other user).

Installation
-----

Copy your SSH public key to authorized_keys:

    $ cat ~/.ssh/id_rsa.pub > cfg_files/bindadm/.ssh/authorized_keys

Edit allowed networks in named.conf:

    $ vim cfg_files/named.conf

Prepare directories for logs and configs (e.g. if want to use zone files):

    $ mkdir /srv/docker_mounts/bind/{logs,configs} -p

Now copy your zonefiles and rest of the configs (except for named.conf which
will be copied by initscript from cfg_files/named.conf) to the
/srv/docker_mounts/bind/configs (this dir will be mounted as /etc/named in the
container).

Clone Dockerfile somewhere and build the container:

    $ sudo docker build -t bind --rm .

Take note of ssh bindadm user password during above build process - you'll
need that later:

    Step 26 : RUN /root/scripts/init.sh
    ...
    bindadm ssh password: YYYYYYYYY

And now run the container:

    On docker 0.8.x:
    $ sudo docker run -dns 127.0.0.1 -t -p 53:53/udp -p 53:53/tcp -p 60022:22/tcp -name bind -v /srv/docker_mounts/bind/logs:/var/log/named:rw -v /srv/docker_mounts/bind/configs:/etc/named:rw -d bind 

    On docker 0.9.x:
    $ sudo docker run -d --dns=127.0.0.1 -p 53:53/udp -p 53:53/tcp -p 60022:22/tcp  --name=bind -v /srv/docker_mounts/bind/logs:/var/log/named:rw -v /srv/docker_mounts/bind/configs:/etc/named:rw bind

In above examples params means:

* - dns 127.0.0.1 - this is a way to use 127.0.0.1 as DNS server in the container
* -p 53:53/udp(tcp) - let's forward external ports from host to container ports (53 - for DNS)
* -p 60022:22/tcp - let's forward external 60022 TCP port to 22 container port for SSH usage
* -v /srv/docker_mounts/bind/logs:/var/log/named:rw - mounting host /srv/.../logs dir in container's /var/log/named dir with rw rights
* -v /srv/docker_mounts/bind/configs:/etc/named:rw - same as above

After running container it should be working fine and you should be able to ssh
to it using ssh key that you pasted before tocfg_files/bindadm/.ssh/authorized_keys

Testing
-----

Just use tools like dig. First check the IP address assigned to container:

    $ sudo docker inspect -format '{{ .NetworkSettings.IPAddress }}' container_id

And next use use dig:

    $ dig google.com @container_IP_ADDR

Also try to ssh to the container with bindadmuser:

    $ ssh bindadm@container_IP

Managing own zone files (domains)
-----

In order to change configuration just edit cfg files in host
/srv/docker_mounts/bind/configs (remember that this dir is mounted on
/etc/named/ in container) and run a command:

    $ ssh bindadm@container_IP "sudo rndc reload"

Managing logfiles
-----

You can access logfiles within host in /srv/docker_mounts/bind/logs; those logs
are rotated by containers logrotate.

You could also switch off logging of all DNS queries (it is turned on in the
included named.conf) - just comment out following lines:

```
        channel log_queries {
                file "/var/log/named/named_queries.log" versions 3 size 20m;
                print-category yes;
                print-severity yes;
                print-time yes;
        };
 
```

Also - as you can see above - logrotate is not needed that much for this
DNS service as size of logfiles is limited in the configuration. Yet logrotate
is included and turned on just to make sure nothing outgrows the FS capacity
in the unpredicted way.
