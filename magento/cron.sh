php bin/magento cron:run | grep -v "Ran jobs by schedule" >> var/log/magento.cron.log
php update/cron.php >> var/log/update.cron.log
php bin/magento setup:cron:run >> var/log/setup.cron.log

