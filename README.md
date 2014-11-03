kisakone-dev
============

Development environment for Kisakone.

Usage
=====

1. Have Virtualbox and Vagrant installed and working.
2. `vagrant up`. Lots of output will happen.
3. Browse to [install.php](http://127.0.0.1/doc/install/install.php) with browser for completing installation.
4. Use hostname `localhost`, database `kisakone`, user `root`, password `pass` and table prefix `kisakone_` for default installation options.

Now you can modify files at your OS and changes are synced automatically to VM.
Kisakone is live at [localhost](http://127.0.0.1/)

When done with development, delete the box: `vagrant destroy -f`.
Code is safe as it is residing outside the box (`../kisakone/`).


Tips
====

After you have once completed the installation, take a backup from your database:

1. Enter Vagrant VM: `vagrant ssh`
2. Execute `mysqldump -uroot -ppass kisakone > /vagrant/kisakone.sql.backup`

From now on, when you do `vagrant destroy -f && vagrant up` to start from a clean slate,
database will be restored from this backup and you don't need to manually do the installation anymore.

