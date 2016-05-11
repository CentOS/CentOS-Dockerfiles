# FreeIPA server in Docker

This repository contains the Dockerfile and associated assets for
building a FreeIPA server Docker image from the official yum repo.

Install docker 1.8+:

    yum install -y docker

Start the service:

    systemctl start docker

To build the image, run in the root of the repository:

    docker build -t freeipa-server .

Create directory which will hold the server data:

    mkdir /var/lib/ipa-data

You can optionally put into this directory a file

    ipa-server-install-options

with command line parameters to ipa-server-install command, one
parameter per line. You probably want at least

    --ds-password=The-directory-server-password
    --admin-password=The-admin-password

If you want to create a replica instead of master, put the GPG-encrypted
replica information file to this directory, plus file

    ipa-replica-install-options

to instruct the container to create a replica. That file should contain
command line parameters to the ipa-replica-install command, possibly at
least

    --password=The-directory-server-password
    --admin-password=The-admin-password

You then run the container with

    docker run --name freeipa-server-container -ti \
       -h ipa.example.test \
       -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
       -v /var/lib/ipa-data:/data:Z freeipa-server

If you do not specify the passwords in the ipa-server-install-options
file, use `PASSWORD` environment variable via the `-e` option:

    docker run --name freeipa-server-container -ti \
       -h ipa.example.test -e PASSWORD=Secret123 \
       -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
       -v /var/lib/ipa-data:/data:Z freeipa-server

If the above fails with error about invalid value for flag -v
and bad format for volumes, run

    chcon -t svirt_sandbox_file_t /var/lib/ipa-data

or use semanage fcontext and restorecon, and use -v option
without the :Z part.

The option `--name` assigns the container a name that can be used
later with `docker start`, `docker stop` and other commands.
Command `ipa-server-install` is invoked non-interactively the first
time the container is run.

You can pass environment variable IPA_SERVER_INSTALL_OPTS with
additional options that will be passed to ipa-server-install.

The `-ti` parameters are optional and are used for get a terminal
(useful for experimenting in the container).

The container can the be started and stopped:

    docker stop freeipa-server-container
    docker start -ai freeipa-server-container

If you want to use the FreeIPA server not just from the host
where it is running but from external machines as well, you
might want to use the `-p` options to make the services accessible
externally. You will then likely want to also specify the
`IPA_SERVER_IP` environment variable via the `-e` option to
define what IP address should the server put to DNS as its
address. Starting the server would then be

    docker run -e IPA_SERVER_IP=10.12.0.98 -p 53:53/udp -p 53:53 \
        -p 80:80 -p 443:443 -p 389:389 -p 636:636 -p 88:88 -p 464:464 \
	-p 88:88/udp -p 464:464/udp -p 123:123/udp -p 7389:7389 \
	-p 9443:9443 -p 9444:9444 -p 9445:9445 ...


# IPA-enrolled client in Docker

There are multiple `*-client` branches named after OS they are
based on. Check out the branch you prefer and in the root of the
repository, run:

    docker build -t freeipa-client .

To run the client container, run it with correctly set DNS
and hostname in the IPA domain, or you can link it to the
freeipa-server container directly:

    docker run --privileged --link freeipa-server-container:ipa \
        -e PASSWORD=Secret123 -ti freeipa-client

The first time this container runs, it invokes `ipa-client-install`
with the given admin password.

# Copyright 2014--2016 Jan Pazdziora

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
