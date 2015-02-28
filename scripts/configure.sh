#!/bin/bash

# mysql2 shortcut
cat <<EOF >/etc/profile.d/mysql2.sh
alias mysql2='mysql -uroot -ppass kisakone'
EOF

# use sample configs for quick startup
if [ ! -e /kisakone/config_site.php ]; then
  cp /kisakone/config_site.php.example /kisakone/config_site.php
fi

# restore backups (expects backup file to contain proper "use database;")
if [ -e "/vagrant/kisakone.sql.backup" ]; then
  echo "Restoring backup SQL from: kisakone.sql.backup"
  mysql -u root --password=pass < /vagrant/kisakone.sql.backup

  echo "Resetting root password to pass"
  mysql -uroot -ppass <<< "GRANT ALL ON *.* TO root@'localhost' IDENTIFIED BY 'pass'; FLUSH PRIVILEGES;"

  echo "Setting up config.php"
  cp /kisakone/config.php.example /kisakone/config.php
  DB=$(cat /vagrant/kisakone.sql.backup | grep "Current Database" | grep kisakone | grep -v "next" | grep -v "test" | head -1 | cut -f2 -d'`' | cut -f1 -d'`')
  if [ "$DB" != "" ]; then
    echo "Detected DB name: $DB - altering config.php for you ..."
    sed -i -e "s,\"kisakone\";,\"$DB\";," /kisakone/config.php
    sed -i -e "s,pass kisakone,pass $DB," /etc/profile.d/mysql2.sh
  fi
  echo "Done! Kisakone restored from backup at http://127.0.0.1:8080/"
else
  echo "Done! Kisakone is waiting for installation at http://127.0.0.1:8080/doc/install/install.php"
fi
