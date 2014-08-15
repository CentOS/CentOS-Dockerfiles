#!/bin/bash

__check() {
if [ -f /var/www/html/wp-config.php ]; then
  exit
fi
}

__create_user() {
# Create a user to SSH into as.
SSH_USERPASS=`pwgen -c -n -1 8`
useradd -G wheel user
echo user:$SSH_USERPASS | chpasswd
echo ssh user password: $SSH_USERPASS
}

__mysql_config() {
# Hack to get MySQL up and running... I need to look into it more.
yum -y erase mysql mysql-server
rm -rf /var/lib/mysql/ /etc/my.cnf
yum -y install mysql mysql-server
mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/bin/mysqld_safe & 
sleep 10
}

__handle_passwords() {
# Here we generate random passwords (thank you pwgen!). The first two are for mysql users, the last batch for random keys in wp-config.php
WORDPRESS_DB="wordpress"
MYSQL_PASSWORD=`pwgen -c -n -1 12`
WORDPRESS_PASSWORD=`pwgen -c -n -1 12`
# This is so the passwords show up in logs. 
echo mysql root password: $MYSQL_PASSWORD
echo wordpress password: $WORDPRESS_PASSWORD
echo $MYSQL_PASSWORD > /mysql-root-pw.txt
echo $WORDPRESS_PASSWORD > /wordpress-db-pw.txt
# There used to be a huge ugly line of sed and cat and pipe and stuff below,
# but thanks to @djfiander's thing at https://gist.github.com/djfiander/6141138
# there isn't now.
sed -e "s/database_name_here/$WORDPRESS_DB/
s/username_here/$WORDPRESS_DB/
s/password_here/$WORDPRESS_PASSWORD/
/'AUTH_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'SECURE_AUTH_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'LOGGED_IN_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'NONCE_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'AUTH_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'SECURE_AUTH_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'LOGGED_IN_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'NONCE_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/" /var/www/html/wp-config-sample.php > /var/www/html/wp-config.php
}

__httpd_perms() {
chown apache:apache /var/www/html/wp-config.php
}

__start_mysql() {
# systemctl start mysqld.service
mysqladmin -u root password $MYSQL_PASSWORD 
mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY '$WORDPRESS_PASSWORD'; FLUSH PRIVILEGES;"
killall mysqld
sleep 10
}

__run_supervisor() {
supervisord -n
}

# Call all functions
__check
__create_user
__mysql_config
__handle_passwords
__httpd_perms
__start_mysql
__run_supervisor
