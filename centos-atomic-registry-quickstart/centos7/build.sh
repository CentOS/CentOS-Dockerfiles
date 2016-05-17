#!/bin/bash

buildurl="mohammedzee1000/centos-cockpit-kubernetes-quickstart";
docker build -t ${buildurl};
docker push ${buildurl};
