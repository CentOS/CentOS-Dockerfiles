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

You can create a postgresql superuser at launch by specifying `POSTGRES_USER` and
`POSGRES_PASSWORD` variables. You may also create a database by using `POSTGRES_DB`. 

    docker run --name postgresql -d \
    -e 'POSTGRES_USER=username' \
    -e 'POSTGRES_PASSWORD=ridiculously-complex_password1' \
    -e 'POSTGRES_DB=my_database' \
    <yourname>/postgresql

If you want to create more than one database, state your databases in
`POSTGRES_DB` each delimited by a semicolon:

    docker run --name postgresql -d \
    -e 'POSTGRES_USER=username' \
    -e 'POSTGRES_PASSWORD=ridiculously-complex_password1' \
    -e 'POSTGRES_DB=my_database;another_database' \
    <yourname>/postgresql

User specified by `POSTGRES_USER` will have granted permissions to all provided databases.

To connect to your database with your newly created user:

    psql -U username -h $(docker inspect --format {{.NetworkSettings.IPAddress}} postgresql)
