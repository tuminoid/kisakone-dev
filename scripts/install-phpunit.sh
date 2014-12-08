#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
add-apt-repository -y ppa:team-mayhem/ppa
apt-get -y update
apt-get -y install php-phpunit-phpunit
