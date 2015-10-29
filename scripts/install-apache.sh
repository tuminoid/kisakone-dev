#!/bin/bash
# expects install-basics.sh to be executed before

export DEBIAN_FRONTEND=noninteractive

# apache
apt-get -y install apache2 libapache2-mod-php5 libapache2-mod-auth-mysql php5-mysql php5-curl php5-mcrypt php5-memcached php5-xdebug
echo "ServerName localhost" > /etc/apache2/conf.d/fqdn
a2enmod php5
a2enmod rewrite
a2dismod status
a2dismod ssl
a2dissite default

cat <<EOF >/etc/apache2/sites-available/kisakone
<VirtualHost *:8080>
        ServerAdmin webmaster@localhost

        DocumentRoot /kisakone

        <Directory /kisakone/>
                Options Indexes FollowSymLinks MultiViews ExecCGI
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/error.log

        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn

        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
a2ensite kisakone

cat <<EOF >/etc/apache2/ports.conf
NameVirtualHost *:8080
Listen 8080
EOF
service apache2 restart

# install phpmyadmin
apt-get -y install debconf-utils
echo "phpmyadmin  phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin  phpmyadmin/reconfigure-webserver  multiselect apache2" | debconf-set-selections
echo "phpmyadmin  phpmyadmin/mysql/admin-pass password pass" | debconf-set-selections
echo "phpmyadmin  phpmyadmin/mysql/method select  unix socket" | debconf-set-selections
echo "phpmyadmin  phpmyadmin/mysql/admin-user string  root" | debconf-set-selections
apt-get -y install phpmyadmin

# install apc opcache
apt-get -y install libpcre3-dev php5-dev php-pear make
echo -e "no\nno\nno\nno\nno\n" | pecl install -f apc
echo "extension=apc.so" >> /etc/php5/apache2/php.ini
service apache2 restart
