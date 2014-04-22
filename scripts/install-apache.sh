#!/bin/sh
# expects install-basics.sh to be executed before

export DEBIAN_FRONTEND=noninteractive

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
