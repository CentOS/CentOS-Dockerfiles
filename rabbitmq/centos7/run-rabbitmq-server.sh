#!/bin/bash

# Setup nss_wrapper with appropriate information
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
export HOME="/var/lib/rabbitmq"
envsubst < /tmp/rabbitmq/passwd.template > /tmp/rabbitmq/passwd
export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD=/tmp/rabbitmq/passwd
export NSS_WRAPPER_GROUP=/etc/group

if [ ! -f /var/lib/rabbitmq/run-rabbitmq-server-firstrun ]; then
	RABBITMQ_USER="${RABBITMQ_USER:-admin}"
	RABBITMQ_PASS="${RABBITMQ_PASS:-`pwgen -s 12 1`}"
	cat >/etc/rabbitmq/rabbitmq.config <<EOF
[
	{rabbit, [{default_user, <<"$RABBITMQ_USER">>}, {default_pass, <<"$RABBITMQ_PASS">>}]}
].
EOF

	echo "set default user = $RABBITMQ_USER and default password = $RABBITMQ_PASS"

	# add the vhost
	touch /var/lib/rabbitmq/run-rabbitmq-server-firstrun
fi

# Check for rabbitmq cookie
if [ "${RABBITMQ_ERLANG_COOKIE:-}" ]; then
	cookieFile='/var/lib/rabbitmq/.erlang.cookie'
		if [ "$(cat "$cookieFile" 2>/dev/null)" != "$RABBITMQ_ERLANG_COOKIE" ]; then
			echo >&2
			echo >&2 "warning: $cookieFile contents do not match RABBITMQ_ERLANG_COOKIE"
			echo >&2
		else
			echo "${RABBITMQ_ERLANG_COOKIE}" > "$cookieFile"
			chmod 600 "$cookieFile"
		fi
fi

exec /usr/sbin/rabbitmq-server
