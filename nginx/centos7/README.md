dockerfiles-centos-nginx
========================

CentOS 7 Dockerfile for nginx, This Dockerfile uses https://www.softwarecollections.org/en/scls/rhscl/rh-nginx18/

This build of nginx listens on port 8080 by default. Please be aware of this
when you launch the container.

error_log and access_log will go to STDOUT.


To build:

Copy the sources down -

    # docker build --rm --tag <username>/nginx:centos7 .

To run:

    # docker run -d -p 80:8080 <username>/nginx:centos7

To test:

    # curl http://localhost
