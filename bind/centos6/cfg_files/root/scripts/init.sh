#/bin/bash

# some ssh sec (disable root login, disable password-based auth):
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
echo "AllowUsers bindadm" >> /etc/ssh/sshd_config
sed -ri 's/session(\s+)required(\s+)pam_loginuid\.so/#/' /etc/pam.d/sshd

mkdir /var/run/sshd
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

# create user bindadm:
SSH_USERPASS=`pwgen -c -n -1 8`
useradd -G wheel -d /home/bindadm bindadm
echo bindadm:$SSH_USERPASS | chpasswd
echo bindadm ssh password: $SSH_USERPASS
mkdir /home/bindadm/.ssh
mv /tmp/authorized_keys /home/bindadm/.ssh/
chown bindadm:bindadm /home/bindadm -R
chmod 600 /home/bindadm/.ssh/authorized_keys
chmod 700 /home/bindadm/.ssh

# set sudo permission for `bindadm` user to allow him rndc command without pwd:
chown root:root /etc/sudoers.d/bindadm
sed -i 's/Defaults    requiretty/#Defaults    requiretty/' /etc/sudoers

# create named.conf template - we'll use it later
mv /etc/named.conf /etc/named.conf.orig
ln -s /etc/named/named.conf  /etc/named.conf

# let's make sure that external mount for named logs has correct owner:
chown named:named /var/log/named
