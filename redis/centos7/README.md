dockerfiles-centos-redis
========================

CentOS 7 Dockerfile for redis

To build:

Copy the sources down -

	# docker build -rm -t <username>/redis-28-centos7 .

To run:

	# docker run -d -p 6379:6379 -e MASTER=true <username>/redis-28-centos7

To test:

	# nc localhost 6379
