#!/bin/sh

# update repos
apt-get update

# mysql
apt-get -y install debconf-utils
echo 'mysql-server-5.5 mysql-server/root_password_again password pass' | debconf-set-selections
echo 'mysql-server-5.5 mysql-server/root_password password pass' | debconf-set-selections
apt-get -y install mysql-server mysql-client

# apache
apt-get -y install apache2 libapache2-mod-php5 libapache2-mod-auth-mysql php5-mysql git php5-memcache
echo "ServerName localhost" > /etc/apache2/conf.d/fqdn
a2enmod php5
a2enmod rewrite
a2enmod mem_cache
a2dissite default
cp /vagrant/kisakone /etc/apache2/sites-available/kisakone
a2ensite kisakone
service apache2 restart

# postfix
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string precise32" | debconf-set-selections
apt-get -y install postfix

# use sample configs for quick startup
cp /kisakone/config.php.sample /kisakone/config.php
cp /kisakone/config_site.php.sample /kisakone/config_site.php

# restore backups (expects backup file to contain proper "use database;")
for FILE in $(ls -1 /vagrant/*.sql.backup); do
  echo "Running SQL from: $FILE"
  mysql -u root --password=pass < $FILE
done
