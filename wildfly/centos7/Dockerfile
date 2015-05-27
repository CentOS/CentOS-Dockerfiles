# Use latest Fedora image as the base
FROM centos:latest
MAINTAINER http://www.centos.org

LABEL Vendor="CentOS"
LABEL License=GPLv2
LABEL Version=8.2.0.Final


# Update base image
RUN yum -y update && yum clean all

# xmlstarlet is useful when modifying attributes/elements
# saxon can be used to execute configuration transformation using XSLT
# augeas is a great tool to edit any configuration files (XML too)
# bsdtar can be used to unpack zip files using pipes
RUN yum -y install tar java-1.7.0-openjdk-devel saxon \ 
    augeas bsdtar shadow-utils && yum clean all

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 8.2.0.Final

# Create the wildfly user and group
RUN groupadd -r wildfly -g 433 && useradd -u 431 -r -g wildfly -d /opt/wildfly -s /sbin/nologin -c "WildFly user" wildfly

# Create directory to extract tar file to
RUN mkdir /opt/wildfly-$WILDFLY_VERSION

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
RUN cd /opt && curl http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | tar zx && chown -R wildfly:wildfly /opt/wildfly-$WILDFLY_VERSION

# Make sure the distribution is available from a well-known place
RUN ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly && chown -R wildfly:wildfly /opt/wildfly

# Set the JBOSS_HOME env variable
ENV JBOSS_HOME /opt/wildfly

# Expose the ports we're interested in
EXPOSE 8080 9990

# Run everything below as the wildfly user
USER wildfly

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/wildfly/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
