# dockerfiles-centos-ssh

# Username & Password

Since the root of the Centos 8 container has no password, if you create and use a new user, you will no longer be able to switch to root, so I changed the root password to "root".

Please remember to change the password to avoid security problems :)

# Building & Running

Copy the sources to your docker host and build the container:

docker:

	# docker build --rm -t <username>/ssh:centos8 .

podman:

	# podman build --rm -t <username>/ssh:centos8 .

To run:

docker:

	# docker run -d -p 22 <username>/ssh:centos8

podman:

	# podman run -d -p 22 <username>/ssh:centos8

To test:

	# ssh -p 22 root@localhost 

