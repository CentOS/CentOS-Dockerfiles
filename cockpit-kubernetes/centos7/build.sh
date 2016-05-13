#!/bin/bash

buildurl="mohammedzee1000/centos-cockpit-kubernetes";
sudo setenforce 0;
echo "Building as ${buildurl}";
docker build -t ${buildurl} .;
docker push ${buildurl};
sudo setenforce 1;
