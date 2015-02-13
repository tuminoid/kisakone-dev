#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# use finnish mirrors
sed -i -e 's,us.archive.ubuntu.com,fi.archive.ubuntu.com,g' /etc/apt/sources.list
sed -i -e 's,http://archive.ubuntu.com,http://fi.archive.ubuntu.com,g' /etc/apt/sources.list

# update repos
apt-get -y update

# basics
apt-get -y install git nano less curl wget nmap command-not-found man software-properties-common ntp

# make ntp more aggressive
sed -i -e 's,server 0.ubuntu.pool.ntp.org,server 0.ubuntu.pool.ntp.org iburst,' /etc/ntp.conf
service ntp restart

# 12.04 has python-software-properties for add-apt-repository,
# which 14.04 handles with software-properties-common
apt-get -y install python-software-properties || true

# install memcached
apt-get -y install memcached php5-memcached
sed -i -e 's,-m 64,-m 128,' /etc/memcached.conf
service memcached restart
