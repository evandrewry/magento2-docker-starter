#!/usr/bin/env bash

[ "$DEBUG" = "true" ] && set -x

CRON_LOG=/var/log/cron.log

# Setup Magento cron
echo "* * * * * root su www-data -s /bin/bash -c 'sh $(pwd)/cron.sh'" > /etc/cron.d/magento

# Get rsyslog running for cron output
touch $CRON_LOG
echo "cron.* $CRON_LOG" > /etc/rsyslog.d/cron.conf
service rsyslog start

# Configure Sendmail if required
if [ "$ENABLE_SENDMAIL" == "true" ]; then
    /etc/init.d/sendmail start
fi

# Configure Xdebug
if [ "$XDEBUG_CONFIG" ]; then
    echo "" > /usr/local/etc/php/conf.d/zz-xdebug.ini
    for config in $XDEBUG_CONFIG; do
        echo "xdebug.$config" >> /usr/local/etc/php/conf.d/zz-xdebug.ini
    done
fi

chown -R www-data .
chgrp -R www-data .
chown -R www-data /var/www/.composer
chgrp -R www-data /var/www/.composer

# Execute the supplied command
exec "$@"
