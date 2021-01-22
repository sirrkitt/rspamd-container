#!/bin/sh
groupmod -g $PGID _rspamd
usermod -u $PUID -g $PGID _rspamd

# make sure we can write to data & config
chown -R $PUID:$PGID /var/lib/rspamd || { echo 'Unable to read/write data folder' ; exit 1; }
chown -R $PUID:$PGID /socket/rspamd || { echo 'Unable to sockets folder' ; exit 1; }

exec /usr/bin/rspamd -f -u _rspamd -g _rspamd
