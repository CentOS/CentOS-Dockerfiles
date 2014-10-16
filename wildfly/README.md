# WildFly Docker image

This is an example Dockerfile with [WildFly application server](http://wildfly.org/).

## Usage

To boot in standalone mode

    docker run -it centos/wildfly

To boot in domain mode

    docker run -it centos/wildfly /opt/wildfly/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0

## Application deployment

With the WildFly server you can [deploy your application in multiple ways](https://docs.jboss.org/author/display/WFLY8/Application+deployment):

1. You can use CLI
2. You can use the web console
3. You can use the management API directly
4. You can use the deployment scanner

The most popular way of deploying an application is using the deployment scanner. In WildFly this method is enabled by default and the only thing you need to do is to place your application inside of the `deployments/` directory. It can be `/opt/wildfly/standalone/deployments/` or `/opt/wildfly/domain/deployments/` depending on [which mode](https://docs.jboss.org/author/display/WFLY8/Operating+modes) you choose (standalone is default in the `centos/wildfly` image -- see above).

The simplest and cleanest way to deploy an application to WildFly running in a container started from the `centos/wildfly` image is to use the deployment scanner method mentioned above.

To do this you just need to extend the `centos/wildfly` image by creating a new one. Place your application inside the `deployments/` directory with the `ADD` command (but make sure to include the trailing slash on the deployment folder path, [more info](https://docs.docker.com/reference/builder/#add)). You can also do the changes to the configuration (if any) as additional steps (`RUN` command).  

[A simple example](https://github.com/goldmann/wildfly-docker-deployment-example) was prepared to show how to do it, but the steps are following:

1. Create `Dockerfile` with following content:

        FROM centos/wildfly
        ADD your-awesome-app.war /opt/wildfly/standalone/deployments/
2. Place your `your-awesome-app.war` file in the same directory as your `Dockerfile`.
3. Run the build with `docker build --tag=wildfly-app .`
4. Run the container with `docker run -it wildfly-app`. Application will be deployed on the container boot.

This way of deployment is great because of a few things:

1. It utilizes Docker as the build tool providing stable builds
2. Rebuilding image this way is very fast (once again: Docker)
3. You only need to do changes to the base WildFly image that are required to run your application

## Extending the image

To be able to create a management user to access the administration console create a Dockerfile with the following content

    FROM centos/wildfly
    RUN /opt/wildfly/bin/add-user.sh admin Admin#70365 --silent

Then you can build the image:

    docker build --tag=centos/wildfly-admin .

Run it:

    docker run -it -p 9990:9990 centos/wildfly-admin

The administration console should be available at http://localhost:9990.

## Building on your own

You don't need to do this on your own, because we prepared a trusted build for this repository, but if you really want:

    docker build --rm=true --tag=centos/wildfly .

## Source
This source is available at
[https://github.com/CentOS/CentOS-Dockerfiles/](https://github.com/CentOS/CentOS-Dockerfiles/)

The original source this is based on can be found at [jboss-dockerfiles](https://github.com/jboss/dockerfiles/tree/master/wildfly).

## Issues

Please report any issues or file RFEs on [GitHub](https://github.com/jboss/dockerfiles/issues).
