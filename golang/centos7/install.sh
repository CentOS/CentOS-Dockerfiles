#!/usr/bin/env bash

# Initialize Variables
PACKAGES="git golang"

mkdir -p /go && chmod -R 777 /go

# Install necessary packages
yum -y install ${PACKAGES};
yum clean all;

