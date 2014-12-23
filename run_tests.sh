#!/bin/bash

TESTS=

usage() {
  echo "usage: $0 [--clean] [install|admin|user|smoke|all]"
  exit 1
}

while [[ $1 ]]; do
  case $1 in
    -h|--help|help) usage ;;
    install) TESTS="--clean 0001-install" ;;
    admin) TESTS="0010-login" ;;
    user) TESTS="--clean 0001-install 0020-users" ;;
    smoke) TESTS="0010-login" ;;
    all|*) TESTS="--clean"; break ;;
  esac
  shift
done

vagrant ssh -- "sudo /vagrant/tools/kisakone-run-tests $TESTS"
