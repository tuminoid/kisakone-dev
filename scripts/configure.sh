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
  DB=$(cat /vagrant/kisakone.sql.backup | grep "Current Database" | grep kisakone | grep -v "next" | grep -v "test" | head -1 | cut -f2 -d'`' | cut -f1 -d'`')
  if [ "$DB" != "" ]; then
    echo "Detected DB name: $DB - altering config.php for you ..."
    sed -i -e "s,\"kisakone\";,\"$DB\";," /kisakone/config.php
  fi
  echo "Done! Kisakone restored from backup at http://127.0.0.1/"
else
  echo "Done! Kisakone is waiting for installation at http://127.0.0.1/doc/install/install.php"
fi

