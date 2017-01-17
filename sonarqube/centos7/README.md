# SonarQube

CentOS 7 Dockerfile for Sonarqube 6.1/6.2

After cloning this repository, you can ...

## Build the container image

```
# docker build --rm --tag <username>/sonarqube-62-centos7 .
```

## Run the container

```
# docker run --detach -p 9000:9000 <username>/sonarqube-62-centos7
```

## Test the container

```
# curl -v -X GET http://localhost:9000
```

This should deliver a HTTP/200

# OpenShift

You can use this container images with OpenShift, we provide

 * BuildConfig - to build the container image inside of OpenShift
 * Template - to create an instance of SonarQube on OpenShift
 * ImageStream - so you can aggregate different versions of SonarQube and use them with the template

## Create ImageStream

To create an ImageStream on OpenShift use `oc create -f imagestream-centos7.yaml`, this will create at least version 6.1 and 6.2 as a Tag in that ImageStream and it will pull image metadata directlry from hub.docker.com

## Setup a Build

`oc create -f build-config.yaml` will create a BuildConfig to build the container image on OpenShift. Please make sure to check the output ImageStreamTag so that it corresponds with the version of SonarQube being built.

## Instanciate an SonarQube Application

`oc process -f sonarqube-template.yaml | oc create -f -`
