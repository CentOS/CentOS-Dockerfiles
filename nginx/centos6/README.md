dockerfiles-centos-nginx
========================

CentOS 6 dockerfile for nginx

To build:

Copy the sources down -

    # docker build -rm -t <username>/nginx:centos6 .

To run:

    # docker run -d -p 80:80 <username>/nginx:centos6

To test:

    # curl http://localhost

