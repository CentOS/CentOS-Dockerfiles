dockerfiles-centos-nginx
========================

CentOS 7 dockerfile for nginx

To build:

Copy the sources down -

    # docker build --rm --tag <username>/nginx:centos7 .

To run:

    # docker run -d -p 80:80 <username>/nginx:centos7

To test:

    # curl http://localhost

