FROM centos/centos:latest

# add our user and group first to make sure their IDs get assigned consistently
RUN groupadd -r sentry && useradd -r -m -g sentry sentry

RUN yum update -y && yum install epel-release -y && yum clean all

RUN yum install -y \
        gcc \
        git \
        libffi-devel \
        libjpeg-devel \
        libpqxx-devel \
        libxml2-devel \
        libxslt-devel \
        libyaml-devel \
        python-devel \
        python-pip \
    && yum clean all

# Sane defaults for pip
ENV PIP_NO_CACHE_DIR off
ENV PIP_DISABLE_PIP_VERSION_CHECK on

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.10
RUN set -x \
    && yum install -y wget && yum clean all \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(if [ `arch` = 'x86_64' ]; then echo 'amd64'; else echo `arch`; fi)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(if [ `arch` = 'x86_64' ]; then echo 'amd64'; else echo `arch`; fi).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && yum remove -y wget

# grab tini for signal processing and zombie killing
ENV TINI_VERSION v0.14.0
RUN set -x \
    && yum update -y && yum install -y wget && yum clean all \
    && wget -O /usr/local/bin/tini "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini" \
    && wget -O /usr/local/bin/tini.asc "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5 \
    && gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini \
    && rm -r "$GNUPGHOME" /usr/local/bin/tini.asc \
    && chmod +x /usr/local/bin/tini \
    && tini -h \
    && yum remove -y wget

# Support for RabbitMQ
RUN set -x \
    && yum update -y && yum install -y make && yum clean all \
    && pip install librabbitmq==1.6.1 \
    && python -c 'import librabbitmq' \
    && yum remove -y make

ENV SENTRY_VERSION 8.22.0

RUN set -x \
    && yum update -y && yum install -y wget g++ gcc-c++ openssl-devel && yum clean all \
    && mkdir -p /usr/src/sentry \
    && wget -O /usr/src/sentry/sentry-${SENTRY_VERSION}-py27-none-any.whl "https://github.com/getsentry/sentry/releases/download/${SENTRY_VERSION}/sentry-${SENTRY_VERSION}-py27-none-any.whl" \
    && wget -O /usr/src/sentry/sentry-${SENTRY_VERSION}-py27-none-any.whl.asc "https://github.com/getsentry/sentry/releases/download/${SENTRY_VERSION}/sentry-${SENTRY_VERSION}-py27-none-any.whl.asc" \
    && wget -O /usr/src/sentry/sentry_plugins-${SENTRY_VERSION}-py2.py3-none-any.whl "https://github.com/getsentry/sentry/releases/download/${SENTRY_VERSION}/sentry_plugins-${SENTRY_VERSION}-py2.py3-none-any.whl" \
    && wget -O /usr/src/sentry/sentry_plugins-${SENTRY_VERSION}-py2.py3-none-any.whl.asc "https://github.com/getsentry/sentry/releases/download/${SENTRY_VERSION}/sentry_plugins-${SENTRY_VERSION}-py2.py3-none-any.whl.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys D8749766A66DD714236A932C3B2D400CE5BBCA60 \
    && gpg --batch --verify /usr/src/sentry/sentry-${SENTRY_VERSION}-py27-none-any.whl.asc /usr/src/sentry/sentry-${SENTRY_VERSION}-py27-none-any.whl \
    && gpg --batch --verify /usr/src/sentry/sentry_plugins-${SENTRY_VERSION}-py2.py3-none-any.whl.asc /usr/src/sentry/sentry_plugins-${SENTRY_VERSION}-py2.py3-none-any.whl \
    && pip install \
        /usr/src/sentry/sentry-${SENTRY_VERSION}-py27-none-any.whl \
        /usr/src/sentry/sentry_plugins-${SENTRY_VERSION}-py2.py3-none-any.whl \
    && sentry --help \
    && sentry plugins list \
    && rm -r "$GNUPGHOME" /usr/src/sentry \
    && yum remove -y wget g++ gcc-c++ openssl-devel

ENV SENTRY_CONF=/etc/sentry \
    SENTRY_FILESTORE_DIR=/var/lib/sentry/files

RUN mkdir -p $SENTRY_CONF && mkdir -p $SENTRY_FILESTORE_DIR

COPY sentry.conf.py /etc/sentry/
COPY config.yml /etc/sentry/

COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 9000
VOLUME /var/lib/sentry/files

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run", "web"]
