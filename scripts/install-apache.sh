#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# update repos
apt-get -y update

# basics
apt-get -y install git nano curl wget nmap command-not-found man

# mysql
apt-get -y install debconf-utils
echo 'mysql-server-5.5 mysql-server/root_password_again password pass' | debconf-set-selections
echo 'mysql-server-5.5 mysql-server/root_password password pass' | debconf-set-selections
apt-get -y install mysql-server mysql-client

# apache
apt-get -y install apache2 libapache2-mod-php5 libapache2-mod-auth-mysql php5-mysql php5-memcache
echo "ServerName localhost" > /etc/apache2/conf.d/fqdn
a2enmod php5
a2enmod rewrite
a2enmod mem_cache
a2dissite default
cp /vagrant/kisakone /etc/apache2/sites-available/kisakone
a2ensite kisakone
service apache2 restart

# postfix
# do not install postfix by default on a development box to avoid mailing people by mistake
if false; then
  echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
  echo "postfix postfix/mailname string precise32" | debconf-set-selections
  apt-get -y install postfix
fi

# use sample configs for quick startup
cp /kisakone/config_site.php.sample /kisakone/config_site.php

# restore backups (expects backup file to contain proper "use database;")
if [ -e "/vagrant/kisakone.sql.backup" ]; then
  echo "Restoring backup SQL from: kisakone.sql.backup"
  mysql -u root --password=pass < /vagrant/kisakone.sql.backup
  cp /kisakone/config.php.sample /kisakone/config.php
  echo "Done! Kisakone restored from backup at http://127.0.0.1/"
else
  echo "Done! Kisakone is waiting for installation at http://127.0.0.1/doc/install/install.php"
fi

