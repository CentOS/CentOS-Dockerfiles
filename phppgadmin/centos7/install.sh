#!/usr/bin/env bash

#!/usr/bin/env bash

set -eux;

# Initialize variables
HTTPD_CONF="/etc/httpd/conf/httpd.conf"
PHP_PGADMIN_HTTPD_CONF="/etc/httpd/conf.d/phpPgAdmin.conf"
HTTPD_WELCOME="/etc/httpd/conf.d/welcome.conf"
INSTALL_PKGS="httpd phpPgAdmin highlight policycoreutils-python nss_wrapper gettext";

# Setup necessary packages
yum -y install epel-release && yum -y install ${INSTALL_PKGS};

# Fixup Configurations
rm -rf ${HTTPD_WELCOME};
sed -i 's/^Listen 80/Listen 8080\\\nListen 8443/g' ${HTTPD_CONF};
sed -i 's/^Listen 8080\\/Listen 8080/g' ${HTTPD_CONF};
sed -i 's/^Group apache/Group root/g' ${HTTPD_CONF};
mkdir -p /etc/httpd/logs && touch /etc/httpd/logs/error_log && touch /etc/httpd/logs/access_log;
cat >${PHP_PGADMIN_HTTPD_CONF} <<EOF
Alias /phpPgAdmin /usr/share/phpPgAdmin

<Location /phpPgAdmin>
    <IfModule mod_authz_core.c>
        # Apache 2.4
        Require all granted
        #Require host example.com
    </IfModule>
    <IfModule !mod_authz_core.c>
        # Apache 2.2
        Order allow, deny
        Allow from all
    </IfModule>
</Location>

EOF

# Fix the permissions
for item in "/etc/httpd" "/var/www" "/usr/share/phpPgAdmin" "/etc/phpPgAdmin" "/var/lib/php"; do
    . /opt/scripts/fix-permissions.sh ${item} apache;
done

chmod -R 777 /etc/httpd/logs
