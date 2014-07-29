dockerfiles-centos-django
========================

CentOS 6 dockerfile for django

Tested on Docker 1.0.0

To build:

Copy the sources down -


\# docker build -rm -t <username>/django:centos6 .



To run:


\# docker run -d -p 8000:8000 <username>/django:centos6


To test:


\# docker run <username>/django:centos6 django-admin --version 

