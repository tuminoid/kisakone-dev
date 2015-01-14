#!/bin/bash

TESTS=

usage() {
  echo "usage: $0 [--clean] [unit | install | user | smoke | all]"
  exit 0
}

while [[ $1 ]]; do
  case $1 in
    unit|unittests) exec ./tools/run_unittests.sh ;;

    install) TESTS="$TESTS --clean install" ;;
    user) TESTS="$TESTS --clean install user_creation user_profile" ;;
    smoke) TESTS="$TESTS user_profile" ;;
    all) ./tools/run_unittests.sh; TESTS=; break ;;
    -h|--help|help|*) usage ;;
  esac
  shift
done

vagrant ssh -- "sudo rm -f /var/log/apache2/error_local.log; sudo service apache2 restart"
vagrant ssh -- "sudo /vagrant/tools/kisakone-run-tests $TESTS"
vagrant ssh -- "sudo cat /var/log/apache2/error_local.log"
