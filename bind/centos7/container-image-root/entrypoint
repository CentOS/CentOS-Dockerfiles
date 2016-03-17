#!/bin/bash

set -x

create_named_data_dir() {
  mkdir -p /named
  chmod -R 0755 /named
  chown -R named:named /named

  if [ ! -d /named/etc ]; then
    mkdir /named/etc
    chmod -R 0755 /named/etc
    chown -R named:named /named/etc

    mv /etc/named.* /named/etc/
    mv /named.conf.default /named/etc/named.conf
  fi

  rm -rf /etc/named
  ln -sf /named/etc /etc/named
  ln -sf /named/etc/named.rfc1912.zones /etc/named.rfc1912.zones
  ln -sf /named/etc/named.root.key /etc/named.root.key
  ln -sf /named/etc/named.iscdlv.key /etc/named.iscdlv.key

  if [ ! -d /named/var ]; then
    mkdir -p /named/var/data
    mkdir -p /named/var/dynamic
    chown -R named:named /named/var
  fi

  (   cd /var/named ; mv named.ca named.empty named.localhost named.loopback /named/var/ )

  rm -rf /var/named
  ln -sf /named/var /var/named

  if [ ! -d /named/log ]; then
    mkdir /named/log
    chmod -R 0755 /named/log
    chown -R root:named /named/log
  fi
}

# main.sh
create_named_data_dir

if [[ ${1:0:1} = '-' ]]; then
  EXTRA_ARGS="$@"
  set --
elif [[ ${1} == '/usr/sbin/named' ]]; then
  EXTRA_ARGS="${@:2}"
  set --
fi

if [[ -z ${1} ]]; then
  echo "Starting named..."
  exec /usr/sbin/named -4 -u named -c /named/etc/named.conf -g ${EXTRA_ARGS}
else
  exec "$@"
fi
