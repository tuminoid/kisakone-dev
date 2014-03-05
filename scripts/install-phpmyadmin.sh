#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# install phpmyadmin
apt-get -y install debconf-utils
echo "phpmyadmin  phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin  phpmyadmin/reconfigure-webserver  multiselect apache2" | debconf-set-selections
echo "phpmyadmin  phpmyadmin/mysql/admin-pass password pass" | debconf-set-selections
echo "phpmyadmin  phpmyadmin/mysql/method select  unix socket" | debconf-set-selections
echo "phpmyadmin  phpmyadmin/mysql/admin-user string  root" | debconf-set-selections

apt-get -y install phpmyadmin
