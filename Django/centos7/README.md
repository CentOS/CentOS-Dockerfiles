dockerfiles-centos-django
========================

CentOS 7 dockerfile for django

Tested on Docker 1.0.0

To build:

Copy the sources down -


\# docker build -rm -t <username>/django:centos7 .



To run:


\# docker run -d -p 8000:8000 <username>/django:centos7


To test:


\# docker run <username>/django:centos7 django-admin --version 

