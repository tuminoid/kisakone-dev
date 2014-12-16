#!/bin/bash

SELENIUM="selenium-server-standalone-2.44.0.jar"
SELENIUM_URL="http://selenium-release.storage.googleapis.com/2.44/$SELENIUM"
CHROMEDRIVER="chromedriver_linux64.zip"
CHROMEDRIVER_URL="http://chromedriver.storage.googleapis.com/2.13"
CACHE="/vagrant/.cache"
export DEBIAN_FRONTEND=noninteractive


# prime cache
mkdir -p $CACHE
apt-get -y update


# install generic site testing tools
apt-get -y install linkchecker siege apache2-utils rsync unzip


# install php-cs-fixer
apt-get -y install wget
wget -nc http://cs.sensiolabs.org/get/php-cs-fixer.phar -O $CACHE/php-cs-fixer
mkdir -p /usr/local/bin
cp $CACHE/php-cs-fixer /usr/local/bin/
chmod 755 /usr/local/bin/php-cs-fixer
cat <<EOF >/usr/local/bin/kisakone-fix-cs
#!/bin/bash

DIR=/kisakone
if [ \$# -gt 0 ]; then
  DIR=\$1
  php-cs-fixer fix \$DIR --fixers=-visibility
else
  # fix code dirs (not Smarty etc)
  for D in core data inputhandlers ui sfl; do
    php-cs-fixer fix \$DIR/\$D --fixers=-visibility
  done

  # fix files
  for F in index.php inputmapping.php; do
    php-cs-fixer fix \$DIR/\$F --fixers=-visibility
  done
fi
EOF
chmod 755 /usr/local/bin/kisakone-fix-cs


# nightwatch.js
apt-get -y install git
cd $CACHE
if [[ ! -e "nightwatch.git" ]]; then
  git clone --mirror https://github.com/beatfactor/nightwatch.git
else
  (cd nightwatch.git && git fetch --all)
fi
cd ~
git clone $CACHE/nightwatch.git
cd nightwatch
npm install


# install java
apt-get -y install openjdk-7-jre-headless


# selenium, with little caching
mkdir -p /usr/lib/selenium
(cd $CACHE && wget -q -nc $SELENIUM_URL)
cp $CACHE/$SELENIUM /usr/lib/selenium/
cat <<EOF >/etc/init.d/selenium
#!/bin/bash

### BEGIN INIT INFO
# Provides:          selenium
# Required-Start:    \$syslog
# Required-Stop:     \$syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start Selenium at boot time
# Description:       Enable service provided by Selenium.
### END INIT INFO

if [ -z "\$1" ]; then
  echo "\`basename \$0\` {start|stop}"
  exit
fi

case "\$1" in
start)
  export DISPLAY=:10
  java -jar /usr/lib/selenium/$SELENIUM -forcedBrowserModeRestOfLine "*firefox /usr/bin/firefox" 2>&1 >/var/log/selenium.log &
;;
stop)
  killall java
;;
esac
EOF
chmod 755 /etc/init.d/selenium
update-rc.d selenium defaults


# chrome and chrome chromedriver
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
apt-get -y update
apt-get -y install google-chrome-stable
(cd $CACHE && wget -q -nc $CHROMEDRIVER_URL/$CHROMEDRIVER)
mkdir -p /usr/local/bin
(cd /usr/local/bin && unzip $CACHE/$CHROMEDRIVER)



# headless display
apt-get -y install dbus-x11 xvfb x11-xkb-utils xfonts-100dpi xfonts-75dpi \
  xfonts-scalable xfonts-cyrillic xserver-xorg-core
echo "export DISPLAY=:10" >> ~/.profile
cat <<EOF >/etc/init.d/xvfb
#!/bin/bash

### BEGIN INIT INFO
# Provides:          xvfb
# Required-Start:    \$syslog
# Required-Stop:     \$syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start XVFB at boot time
# Description:       Enable service provided by XVFB.
### END INIT INFO

if [ -z "\$1" ]; then
  echo "\`basename \$0\` {start|stop}"
  exit
fi

case "\$1" in
start)
  /usr/bin/Xvfb :10 -ac -screen 0 1024x768x8 2>&1 >/var/log/xvfb.log &
;;
stop)
  killall Xvfb
;;
esac
EOF
chmod 755 /etc/init.d/xvfb
update-rc.d xvfb defaults


# start the services
service xvfb start
service selenium start


# apache config
cat <<EOF >/etc/apache2/sites-available/test
<VirtualHost *:8081>
        ServerAdmin webmaster@localhost

        DocumentRoot /kisakone_local

        <Directory /kisakone/>
                Options Indexes FollowSymLinks MultiViews ExecCGI
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error_local.log

        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn

        CustomLog ${APACHE_LOG_DIR}/access_local.log combined
</VirtualHost>
EOF
a2ensite test
service apache2 reload


# kisakone tests
cat <<EOF >/usr/local/bin/kisakone-run-tests
#!/bin/bash

[[ ! -d /kisakone ]] && echo "error: /kisakone not found" && exit 1
mkdir -p /kisakone_local
rsync -a --delete --exclude=.git --exclude=config.php --exclude=Smarty/templates_c /kisakone/ /kisakone_local/
chown -R www-data:www-data /kisakone_local

cd /vagrant/tests

if [[ \$# -gt 0 ]]; then
  sudo /root/nightwatch/bin/nightwatch -c nightwatch-settings.json --skipgroup 0001-install --groups \$*
else
  cat <<EOS | mysql -u root --password=pass
drop database if exists test_kisakone;
EOS
  rm -f /kisakone_local/config.php
  sudo /root/nightwatch/bin/nightwatch -c nightwatch-settings.json
fi
EOF
chmod 755 /usr/local/bin/kisakone-run-tests

echo "Test environment setup at 'http://127.0.0.1:8081/!"
echo "  Run Kisakone Unit Test suite with './run_unittests.sh'!"
echo "  Run Kisakone UI test suite with './run_tests.sh [category]'!"
echo "  Fix coding style before committing with 'kisakone-fix-cs [dir]'!"
