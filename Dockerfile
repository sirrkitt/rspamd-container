FROM debian:buster

ENV	V=2.7-42
ENV	PUID=101
ENV	PGID=101

RUN	apt-get update && apt-get install -y --no-install-recommends gnupg ca-certificates

ADD	https://rspamd.com/apt/gpg.key /tmp/rspamd.key

RUN	apt-key add /tmp/rspamd.key

RUN	echo "deb https://rspamd.com/apt-stable/ buster main" > /etc/apt/sources.list.d/rspamd.list

RUN	apt-get update \
	&& apt-get install -y rspamd \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /etc/rspamd/local.d /etc/rspamd/override.d

COPY	entrypoint.sh /entrypoint.sh

VOLUME	[ "/var/lib/rspamd", "/etc/rspamd/local.d", "/etc/rspamd/override.d", "/socket/rspamd" ]

CMD	[ "/entrypoint.sh" ]

EXPOSE	11333 11334
