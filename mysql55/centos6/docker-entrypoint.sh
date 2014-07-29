#!/bin/bash

# Borrowed from https://github.com/docker-library/docker-mysql

set -e

if [ -z "$(ls -A /var/lib/mysql)" -a -n "$MYSQL_ROOT_PASSWORD" ]; then
	if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
		echo >&2 'error: database is uninitialized and MYSQL_ROOT_PASSWORD not set'
		echo >&2 '  Did you forget to add -e MYSQL_ROOT_PASSWORD=... ?'
		exit 1
	fi
	
	scl enable mysql55 "mysql_install_db --user=mysql --datadir=/var/lib/mysql"
	
	# These statements _must_ be on individual lines, and _must_ end with
	# semicolons (no line breaks or comments are permitted).
	# TODO proper SQL escaping on dat root password D:
	cat > /tmp/mysql-first-time.sql <<-EOSQL
		UPDATE mysql.user SET host = "%", password = PASSWORD("${MYSQL_ROOT_PASSWORD}") WHERE user = "root" LIMIT 1 ;
		DELETE FROM mysql.user WHERE user != "root" OR host != "%" ;
		DROP DATABASE IF EXISTS test ;
		FLUSH PRIVILEGES ;
	EOSQL
	
	scl enable mysql55 "mysqld_safe --init-file=/tmp/mysql-first-time.sql &"
	sleep 5
	exec scl enable mysql55 "mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown"
fi

chown -R mysql:mysql /var/lib/mysql
exec scl enable mysql55 "mysqld_safe --datadir=/var/lib/mysql --user=mysql"
