dockerfiles-centos-bind
========================

CentOS 7 dockerfile for Bind9 - based resolving & cache'ing (DNS server). It is
listening on IPv4 only.

Configuration
-----

By default legit networks are 127.0.0.1 and whole 172.16.0.0/12 private network
(as Docker uses those ranges for internal networking). The default CentOS named.conf
file will be replaced by one that contains these networks.

Installation
-----

Prepare directories for logs and configurations (e.g. if want to use zone files):

    $ sudo mkdir -p /srv/docker/bind9
    $ sudo chcon -Rt svirt_sandbox_file_t /srv/docker/bind9

You will find default CentOS configuration files in /srv/docker/bind9/etc after
the first start of this container images.

Clone Dockerfile somewhere and build the container:

    $ sudo docker build --tag bind9 --rm .

And now run the container:

    $ sudo docker run --detach --name bind --publish 54:54/udp --volume /srv/docker/bind9:/named bind


In above examples params means:

* --publish 53:53/udp(tcp) - let's forward external ports from host to container ports (53 - for DNS)
* --volume /srv/docker/bind9:/named - mounting host /srv/docker/bind9/ dir in container's /named dir with rw rights

After running container it should be working fine.

Testing
-----

Just use tools like dig. First check the IP address assigned to container:

    $ sudo docker inspect -format '{{ .NetworkSettings.IPAddress }}' container_id

And next use use dig:

    $ dig google.com @container_IP_ADDR


Managing own zone files (domains)
-----

In order to change configuration just edit cfg files in host
/srv/docker_mounts/bind/configs (remember that this dir is mounted on
/etc/named/ in container) and run a command:

    $ ssh bindadm@container_IP "sudo rndc reload"

Managing logfiles
-----

You can access logfiles within host in /srv/docker/bind9/log.

TODO: logrotation of named's log files.

You could also switch off logging of all DNS queries, just comment out following lines:

```
        channel log_queries {
                file "/var/log/named/named_queries.log" versions 3 size 20m;
                print-category yes;
                print-severity yes;
                print-time yes;
        };

```
