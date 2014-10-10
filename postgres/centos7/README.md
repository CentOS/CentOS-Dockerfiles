dockerfiles-centos-postgres
===========================

Dockerfile to build PostgreSQL on CentOS 7

Setup
-----

To build the image

    # docker build --rm -t <yourname/postgresql .


Launching PostgreSQL
--------------------

#### Quick Start (not recommended for production use)

    docker run --name=postgresql -d -p 5432:5432 <yourname>/postgresql


To connect to the container as the administrative `postgres` user:

    docker run -it --rm --volumes-from=postgresql <yourname>/postgres sudo -u
    postgres -H psql


Creating a database at launch
-----------------------------

You can create a postgresql superuser at launch by specifying `DB_USER` and
`DB_PASS` variables. You may also create a database by using `DB_NAME`. 

    docker run --name postgresql -d \
    -e 'DB_USER=username' \
    -e 'DB_PASS=ridiculously-complex_password1' \
    -e 'DB_NAME=my_database' \
    <yourname>/postgresql

To connect to your database with your newly created user:

    psql -U username -h $(docker inspect --format {{.NetworkSettings.IPAddress}} postgresql)
