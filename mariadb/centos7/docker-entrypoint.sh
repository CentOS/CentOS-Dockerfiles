#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- mysqld_safe "$@"
fi

if [ "$1" = 'mysqld_safe' ]; then
	DATADIR="/var/lib/mysql"
	
	if [ ! -d "$DATADIR/mysql" ]; then
		if [ -z "$MYSQL_ROOT_PASSWORD" -a -z "$MYSQL_ALLOW_EMPTY_PASSWORD" -a -z "$MARIADB_ROOT_PASSWORD" -a -z "$MARIADB_ALLOW_EMPTY_PASSWORD" ]; then
			echo >&2 'error: database is uninitialized and MYSQL_ROOT_PASSWORD/MARIADB_ROOT_PASSWORD not set'
			echo >&2 '  Did you forget to add -e MYSQL_ROOT_PASSWORD=... ?'
			exit 1
		fi
		
		echo 'Running mysql_install_db ...'
		mysql_install_db --datadir="$DATADIR"
		echo 'Finished mysql_install_db'
		
		# These statements _must_ be on individual lines, and _must_ end with
		# semicolons (no line breaks or comments are permitted).
		# TODO proper SQL escaping on ALL the things D:
		
		tempSqlFile='/tmp/mysql-first-time.sql'
		ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:=${MARIADB_ROOT_PASSWORD}}
		cat > "$tempSqlFile" <<-EOSQL
			DELETE FROM mysql.user ;
			CREATE USER 'root'@'%' IDENTIFIED BY '${ROOT_PASSWORD}' ;
			GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
			DROP DATABASE IF EXISTS test ;
		EOSQL
		
		DATABASE=${MYSQL_DATABASE:=${MARIADB_DATABASE}}
		CHARSET=${MYSQL_CHARSET:=${MARIADB_CHARSET}}
		COLLATION=${MYSQL_COLLATION:=${MARIADB_COLLATION}}
		DB_USER=${MYSQL_USER:=${MARIADB_USER}}
		DB_PASSWORD=${MYSQL_PASSWORD:=${MARIADB_PASSWORD}}
		if [ "$DATABASE" ]; then
			echo "CREATE DATABASE IF NOT EXISTS \`$DATABASE\` ;" >> "$tempSqlFile"
			if [ "$CHARSET" ]; then
				echo "ALTER DATABASE \`$DATABASE\` CHARACTER SET \`$CHARSET\` ;" >> "$tempSqlFile"
			fi
			
			if [ "$COLLATION" ]; then
				echo "ALTER DATABASE \`$DATABASE\` COLLATE \`$COLLATION\` ;" >> "$tempSqlFile"
			fi
		fi
		
		if [ "$DB_USER" -a "$DB_PASSWORD" ]; then
			echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD' ;" >> "$tempSqlFile"
			
			if [ "$DATABASE" ]; then
				echo "GRANT ALL ON \`$DATABASE\`.* TO '$DB_USER'@'%' ;" >> "$tempSqlFile"
			fi
		fi
		
		echo 'FLUSH PRIVILEGES ;' >> "$tempSqlFile"
		
		set -- "$@" --init-file="$tempSqlFile"
	fi
	
fi

exec "$@"
