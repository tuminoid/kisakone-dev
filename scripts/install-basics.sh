#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

# update repos
apt-get -y update

# basics
apt-get -y install git nano curl wget nmap command-not-found man software-properties-common

# 12.04 has python-software-properties for add-apt-repository,
# which 14.04 handles with software-properties-common
apt-get -y install python-software-properties || true
