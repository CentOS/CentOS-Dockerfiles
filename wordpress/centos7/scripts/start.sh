#!/bin/bash

__handle_passwords() {
DB_NAME="{$DB_NAME}"
if [ -z "$DB_NAME" ]; then
  cat <<EOF
No  DB_NAME variable. Please link to database using alias 'db'
or provide DB_NAME variable.
EOF
  exit 1
fi
if [ -z "$DB_ENV_MYSQL_USER" ]; then
  printf "No DB_ENV_MYSQL_USER variable. Please link to database using alias 'db'.\n"
  exit 1
fi
# Here we generate random passwords (thank you pwgen!) for random keys in wp-config.php
printf "Creating wp-config.php...\n"
# There used to be a huge ugly line of sed and cat and pipe and stuff below,
# but thanks to @djfiander's thing at https://gist.github.com/djfiander/6141138
# there isn't now.
sed -e "s/database_name_here/$DB_ENV_MYSQL_DATABASE/
s/username_here/$DB_ENV_MYSQL_USER/
s/password_here/$DB_ENV_MYSQL_PASSWORD/" /var/www/html/wp-config-sample.php > /var/www/html/wp-config.php
RE='put your unique phrase here'
for i in {1..8}; do
  KEY=$(openssl rand -base64 40)
  sed -i "0,/$RE/s|$RE|$KEY|" /var/www/html/wp-config.php
done
}

__handle_db_host() {
# Update wp-config.php to point to our linked container's address.
sed -i -e "s/^\(define('DB_HOST', '\).*\(');.*\)/\1${DB_PORT#tcp://}\2/" \
  /var/www/html/wp-config.php
}

__httpd_perms() {
chown apache:apache /var/www/html/wp-config.php
}

__run_apache() {
exec /scripts/run-apache.sh
}

__check() {
if [ ! -f /var/www/html/wp-config.php ]; then
  __handle_passwords
  __httpd_perms
fi
__handle_db_host
}

# Call all functions
__check
__run_apache
