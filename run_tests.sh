#!/bin/bash

TESTS=

usage() {
  echo "usage: $0 [--clean] [unit | install | user | smoke | all]"
  exit 1
}

while [[ $1 ]]; do
  case $1 in
    unit|unittests) exec ./tools/run_unittests.sh ;;

    install) TESTS="$TESTS --clean install" ;;
    user) TESTS="$TESTS --clean install user_creation user_profile" ;;
    smoke) TESTS="$TESTS user_profile" ;;
    all) ./tools/run_unittests.sh; break ;;
    -h|--help|help|*) usage ;;
  esac
  shift
done

vagrant ssh -- "sudo /vagrant/tools/kisakone-run-tests $TESTS"
