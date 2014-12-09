#!/bin/sh

vagrant ssh -- "cd /vagrant/unittests; ./run_tests.sh $*"

