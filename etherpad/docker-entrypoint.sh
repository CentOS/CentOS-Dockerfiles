#!/bin/bash
set -eux 

# If the database is not "linked" then an external database is being
# used and the user is expected to set the following variables on the
# docker command line:
#   
#   DB_HOST - The hostname to reach for the db
#   DB_DBID - The database name
#   DB_PASS - The database password
#   DB_PORT - The port where the db is listening
#   DB_USER - The database username

# If the database is "linked" (docker run --link) to this container 
# from a db container then translate the vars into ones that we will use.
# NOTE: assumes linked alias is 'db'
if [ ! -z "${DB_NAME:-}" ]; then
    DB_HOST="${DB_PORT_3306_TCP_ADDR}"
    DB_DBID="${DB_ENV_MYSQL_DATABASE}"
    DB_PASS="${DB_ENV_MYSQL_PASSWORD}"
    DB_PORT="${DB_PORT_3306_TCP_PORT}"
    DB_USER="${DB_ENV_MYSQL_USER}"
fi

# Update the settings.json with appropriate values
sed -i "s/DB_HOST/${DB_HOST}/" settings.json
sed -i "s/DB_DBID/${DB_DBID}/" settings.json
sed -i "s/DB_PASS/${DB_PASS}/" settings.json
sed -i "s/DB_PORT/${DB_PORT}/" settings.json
sed -i "s/DB_USER/${DB_USER}/" settings.json

# Execute the etherpad provided startup script
./bin/run.sh $@
