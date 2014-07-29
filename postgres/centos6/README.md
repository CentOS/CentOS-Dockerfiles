dockerfiles-centos-postgres
===========================

CentOS 6 dockerfile for PostgreSQL

1.	To build

Copy the sources down and do the build-

    # docker build -rm -t username/postgresql:centos6 . |& tee postgres_build.log

2.	To run 

If port 5432 is open on your host:

    # docker run -d -p 5432:5432 username/postgresql:centos6

or to assign a random port that maps to port 5432 on the container:

    # docker run -d -p 5432 username/postgresql:centos6

To see the random port that the container is listening on:

    # docker ps

3.	To test 

To find the IP address, get the container ID:

    # docker ps

Then get the IP addr:

    # docker inspect 7a1e1a80e948 | grep -i ipaddress

Now connect to the database.  In this case, it's called 'dockerdb' and the
username is 'dockeruser' with a password of 'password', which was set via the
postgres_user.sh script.

    # psql -h 172.17.0.x -U dockeruser -d dockerdb

