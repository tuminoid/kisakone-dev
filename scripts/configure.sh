#!/bin/bash

# use sample configs for quick startup
if [ ! -e /kisakone/config_site.php ]; then
  cp /kisakone/config_site.php.sample /kisakone/config_site.php
fi

# restore backups (expects backup file to contain proper "use database;")
if [ -e "/vagrant/kisakone.sql.backup" ]; then
  echo "Restoring backup SQL from: kisakone.sql.backup"
  mysql -u root --password=pass < /vagrant/kisakone.sql.backup
  cp /kisakone/config.php.sample /kisakone/config.php
  echo "Done! Kisakone restored from backup at http://127.0.0.1/"
else
  echo "Done! Kisakone is waiting for installation at http://127.0.0.1/doc/install/install.php"
fi

