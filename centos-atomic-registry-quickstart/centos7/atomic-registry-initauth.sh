#!/bin/bash

# Get the type of authentication that needs to be initialized.
authtype=$1;

# * Initializing required variables.
ymlfile="/etc/origin/master/master-config.yaml";
#ymlfile="test.yaml";

htpassfile="/etc/origin/master/users.htpasswd";
#htpassfile="users.htpasswd";

tmpyml="tmp.yml";
injectfile="injectfile$RANDOM";

# * Create temp copy of ymlfile and also create a backup copy.
cp -rf $ymlfile $tmpyml;
cp -rf $ymlfile "$ymlfile.back";

# * Create injectfile to inject htpasswd auth info to actual config file.
cat <<EOF >> $injectfile
  - challenge: true
    login: true
    mappingMethod: claim
    name: htpasswdauth
    provider:
      apiVersion: v1
      kind: HTPasswdPasswordIdentityProvider
      file: /etc/origin/master/users.htpasswd
EOF

# * Update the config file with new auth information
sed -i "/\s\sidentityProviders\:/{n;N;N;N;N;N;N;d}" $tmpyml;
sed -i "/\s\sidentityProviders\:/r $injectfile" $tmpyml &> /dev/null;

# * Writeback to orignal config file and remove temp files.
cat $tmpyml > $ymlfile;
rm -rf $tmpyml $injectfile;
