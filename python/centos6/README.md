dockerfiles-centos-python
=========================

CentOS 6 dockerfile for python

Get Docker version

    # docker version

To build:

Copy the sources down and do the build-

    # docker build -rm -t <username>/python:centos6 .

To run (if port 8080 is open on your host):

    # docker run -d -p 8080:8080 <username>/python:centos6

or to assign a random port that maps to port 80 on the container:

    # docker run -d -p 8080 <username>/python:centos6

To the port that the container is listening on:

    # docker ps

To test:

    # curl http://localhost:8080
