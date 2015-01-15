#!/bin/bash

TESTS=

usage() {
  echo "usage: $0 [--clean] [unit | install | user | smoke | all]"
  exit 0
}

check_syntax() {
  DIR=$1
  which php >/dev/null || return 0


  echo -n "syntax check: "
  for PHP in $(find $DIR -name '*.php'); do
    if echo $PHP | grep -q "Smarty/templates"; then
      continue
    fi

    echo -n "."
    if ! php -l $PHP >/dev/null; then
      php -l $PHP
      exit 1
    fi
  done
  echo " : ok"
}

while [[ $1 ]]; do
  case $1 in
    unit|unittests) check_syntax unittests; exec ./tools/run_unittests.sh ;;
    syntax) check_syntax ../kisakone ;;

    install) TESTS="$TESTS --clean 0install admin" ;;
    user) TESTS="$TESTS --clean 0install user_creation user_profile" ;;
    smoke) TESTS="$TESTS user_profile" ;;
    all) check_syntax ../kisakone; ./tools/run_unittests.sh; TESTS=; break ;;
    -h|--help|help|*) usage ;;
  esac
  shift
done

vagrant ssh -- "sudo rm -f /var/log/apache2/error_local.log; sudo service apache2 restart"
vagrant ssh -- "sudo /vagrant/tools/kisakone-run-tests $TESTS"
vagrant ssh -- "sudo cat /var/log/apache2/error_local.log"
