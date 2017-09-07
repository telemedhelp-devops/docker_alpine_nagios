#!/bin/sh

mkdir -p /var/log/nagios
chown nagios:nagios /var/log/nagios /etc/nagios/home/.ssh/docker-key

# to be able to send notifications
postfix start 2>&1 | grep -v warning &

# to monitor services
su -l nagios -c 'nagios /etc/nagios/nagios.cfg' &

# to do reports (on HTTP request)
fcgiwrap -s tcp:0.0.0.0:9002 &

# the rest part of HTTP-interface
php-fpm &

# waiting for infinity
tail -f /dev/null
