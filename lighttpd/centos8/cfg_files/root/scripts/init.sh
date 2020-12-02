#!/bin/bash

# some ssh sec (disable root login, disable password-based auth):
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
echo "AllowUsers lighttpd" >> /etc/ssh/sshd_config
sed -ri 's/session(\s+)required(\s+)pam_loginuid\.so/#/' /etc/pam.d/sshd

mkdir /var/run/sshd
ssh-keygen -A

# set user's lighttpd env:
SSH_USERPASS=`pwgen -c -n -1 8`
mkdir /home/lighttpd/.ssh -p
usermod -d /home/lighttpd lighttpd
usermod -s /bin/bash lighttpd
chown lighttpd:lighttpd /home/lighttpd -R
usermod -G wheel lighttpd
echo lighttpd:$SSH_USERPASS | chpasswd
echo lighttpd ssh password: $SSH_USERPASS
mv /tmp/authorized_keys /home/lighttpd/.ssh/
chown lighttpd:lighttpd /home/lighttpd -R

mkdir -p /srv/httpd/htdocs
chown lighttpd:lighttpd /srv/httpd/htdocs -R

chmod 600 /home/lighttpd/.ssh/authorized_keys
chmod 700 /home/lighttpd/.ssh

# create config template - we'll use it later (after mounting via external fs)
mv /etc/lighttpd /etc/lighttpd.template
sed -i 's/server.groupname = "www"/server.groupname = "lighttpd"/' /etc/lighttpd.template/lighttpd.conf
sed -i 's/server.username  = "www"/server.username  = "lighttpd"/' /etc/lighttpd.template/lighttpd.conf

# make sure logs are accessible from lighttpd user:
chown lighttpd:lighttpd /var/log/lighttpd

# set sudo permission for `lighttpd` user to allow him rndc command without pwd:
chown root:root /etc/sudoers.d/lighttpd
sed -i 's/Defaults    requiretty/#Defaults    requiretty/' /etc/sudoers
