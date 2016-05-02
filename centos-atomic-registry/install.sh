#!/bin/bash

IMAGES=(openshift/origin openshift/origin-pod openshift/origin-deployer openshift/origin-docker-registry mohammedzee1000/centos-cockpit-kubernetes)

for IMAGE in "${IMAGES[@]}"
do
  chroot /host docker pull $IMAGE
done

docker tag openshift/origin-pod:latest openshift/origin-pod:v1.2.0-rc1-3-g4a17672;
docker tag openshift/origin-deployer openshift/origin-deployer:v1.2.0-rc1-3-g4a17672;

INSTALL_HOST=${1:-`hostname`}
echo "Installing using hostname ${INSTALL_HOST}"

# write out configuration
openshift start --write-config /etc/origin/ --etcd-dir /var/lib/origin/etcd --volume-dir /var/lib/origin/volumes --public-master ${INSTALL_HOST}

echo "Copy files to host"

set -x
mv /host/etc/origin/node-* /host/etc/origin/node

mkdir -p /host/etc/origin/registry/bin
mkdir -p /host/etc/origin/master/site
cp /container/bin/* /host/etc/origin/registry/bin/.
cp /container/etc/origin/registry-console-template.yaml /host/etc/origin/registry/.
cp /container/etc/origin/registry-newproject-template-shared.json /host/etc/origin/registry/.
cp /container/etc/origin/registry-newproject-template-unshared.json /host/etc/origin/registry/.
cp /container/etc/origin/registry-login-template.html /host/etc/origin/master/site/.
# Create registry UI service certificates -- TODO: use this cert
cat /etc/origin/master/master.server.crt /etc/origin/master/master.server.key > /etc/origin/registry/master.server.cert

set +x

echo "Updating servicesNodePortRange to 443-32767..."
sed -i 's/  servicesNodePortRange:.*$/  servicesNodePortRange: 443-32767/' /etc/origin/master/master-config.yaml
echo "Updating login template"
sed -i 's/  templates: null$/  templates:\n    login: site\/registry-login-template.html/' /etc/origin/master/master-config.yaml

cp /container/etc/origin/users.htpasswd /host/etc/origin/master/.
chmod +x /container/etc/origin/atomic-registry-initauth.sh
/container/etc/origin/atomic-registry-initauth.sh ${REG_AUTHPROVIDER}

echo "######################### IMPORTANT #####################################"
echo "Optionally edit configuration file /etc/origin/master/master-config.yaml,"
echo "add certificates to /etc/origin/master,"
echo "then run 'atomic run mohammedzee1000/centos-atomic-registry ${INSTALL_HOST}'"
echo "######################## DEFAULT AUTHENTICATION #########################";
echo "By default, two users are available admin/admin@123 pulluser@pulluser@123";
echo "These users details are located at /etc/origin/master/users.htpasswd, edit";
echo "to change password";
