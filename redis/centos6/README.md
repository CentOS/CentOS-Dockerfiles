dockerfiles-centos-redis
========================

CentOS 6 dockerfile for redis

To build:

Copy the sources down -

	# docker build -rm -t <username>/redis:centos6 .

To run:

	# docker run -d -p 6379:6379 <username>/redis:centos6

To test:

	# nc localhost 6379

