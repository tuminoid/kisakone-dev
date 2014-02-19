kisakone-dev
============

Development environment for Kisakone.

Usage
=====

1. Have Virtualbox and Vagrant installed and working.
2. `vagrant up`
3. Browse to `http://127.0.0.1/doc/install/install.php` with browser for completing installation
4. You can modify files at your OS and changes are synced automatically to VM.


Tips
====

After you have once completed the installation, take a backup from your database:

1. Enter Vagrant VM: `vagrant ssh`
2. Execute `mysqldump -u [user] -p [db] > /vagrant/kisakone.sql.backup`

From now on, when you do `vagrant destroy -f && vagrant up` to start from a clean slate,
database will be restored from this backup and you don't need to manually do the installation anymore.

