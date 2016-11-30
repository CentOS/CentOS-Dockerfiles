# dockerfiles-centos-ssh

# Building & Running

Copy the sources to your docker host and build the container:

	# docker build --rm -t <username>/ssh:centos7 .

To run:

	# docker run -d -p 22 <username>/ssh:centos7

Get the port that the container is listening on:

```
# docker ps
CONTAINER ID        IMAGE                 COMMAND             CREATED             STATUS              PORTS                   NAMES
8c82a9287b23        <username>/ssh:centos7   /usr/sbin/sshd -D   4 seconds ago       Up 2 seconds        0.0.0.0:49154->22/tcp   mad_mccarthy        
```

To test, use the port that was just located:

	# ssh -p xxxx user@localhost 

