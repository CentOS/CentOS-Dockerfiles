#!/bin/bash

if [ ! -f /.run-rabbitmq-server-firstrun ]; then
	RABBITMQ_USER="${RABBITMQ_USER:-admin}"
	RABBITMQ_PASS="${RABBITMQ_PASS:-`pwgen -s 12 1`}"
	cat >/etc/rabbitmq/rabbitmq.config <<EOF
[
	{rabbit, [{default_user, <<"$RABBITMQ_USER">>}, {default_pass, <<"$RABBITMQ_PASS">>}]}
].
EOF

	echo "set default user = $RABBITMQ_USER and default password = $RABBITMQ_PASS"

	# add the vhost
	touch /.run-rabbitmq-server-firstrun
fi

exec /usr/sbin/rabbitmq-server
