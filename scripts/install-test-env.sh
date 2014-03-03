#!/bin/sh

SELENIUM="selenium-server-standalone-2.39.0.jar"
CACHE="/vagrant/.cache"


# prime cache
mkdir -p $CACHE
apt-get -y update


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
  for D in core data inputhandlers ui; do
    php-cs-fixer fix \$DIR/\$D --fixers=-visibility
  done

  # fix files
  for F in helpers.php index.php inputmapping.php sfl_integration.php; do
    php-cs-fixer fix \$DIR/\$F --fixers=-visibility
  done
fi
EOF
chmod 755 /usr/local/bin/kisakone-fix-cs


# nodejs
apt-get -y install python-software-properties python g++ make
add-apt-repository -y ppa:chris-lea/node.js
apt-get -y update
apt-get -y install nodejs


# nightwatch.js
apt-get -y install git
cd ~
git clone https://github.com/beatfactor/nightwatch.git
cd nightwatch
npm install


# install java
apt-get -y install openjdk-7-jre-headless


# selenium, with little caching
apt-get -y install wget
mkdir -p /usr/lib/selenium
(cd $CACHE && wget -q -nc https://selenium.googlecode.com/files/$SELENIUM)
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
  echo "`basename \$0` {start|stop}"
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


# firefox and headless display
apt-get -y install firefox dbus-x11
apt-get -y install xvfb x11-xkb-utils xfonts-100dpi xfonts-75dpi \
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
  echo "`basename \$0` {start|stop}"
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


# kisakone tests
cat <<EOF >/usr/local/bin/kisakone-run-tests
#!/bin/bash

cd /vagrant/tests
/root/nightwatch/bin/nightwatch -c nightwatch-settings.json $@
EOF
chmod 755 /usr/local/bin/kisakone-run-tests
echo "Test environment setup done!"
echo "  Run Kisakone UI test suite with 'kisakone-run-tests [category]'!"
echo "  Fix coding style before committing with 'kisakone-fix-cs [dir]'!"
