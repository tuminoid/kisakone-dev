#!/bin/bash

TESTS=

usage() {
  echo "usage: $0 [--clean] [unit | install | user | smoke | all]"
  exit 0
}

check_syntax() {
  DIR=$1
  which php >/dev/null || return 0

  # stupid osx hack
  if [[ $(uname -s) == "Darwin" ]]; then
    FILES=$(find $DIR -name '*.php' -exec stat -f '%m %N' {} \; | sort -nr | cut -f2 -d' ' | grep -v "Smarty")
  else
    FILES=$(find $DIR -name '*.php' -printf "%C@ %p\n" | sort -r | cut -f2 -d' ' | grep -v "Smarty")
  fi

  # check syntax in modification time ordered
  echo -n "syntax check: "
  for PHP in $FILES; do
    echo -n "."
    if ! php -l $PHP >/dev/null; then
      php -l $PHP
      exit 1
    fi
  done
  echo " ok"
}

while [[ $1 ]]; do
  case $1 in
    unit|unittests) check_syntax unittests; exec ./tools/run_unittests.sh ;;
    syntax) check_syntax ../kisakone; exit $? ;;

    install) TESTS="$TESTS --clean 0install admin" ;;
    user) TESTS="$TESTS --clean 0install user_creation user_profile" ;;
    event) TESTS="$TESTS --clean 0install event" ;;
    all) check_syntax ../kisakone; ./tools/run_unittests.sh; TESTS=; break ;;
    -h|--help|help|*) usage ;;
  esac
  shift
done

vagrant ssh -- "sudo rm -f /var/log/*/error_local.log; sudo service apache2 reload 2>/dev/null; sudo service nginx reload 2>/dev/null"
vagrant ssh -- "sudo /vagrant/tools/kisakone-run-tests $TESTS"
vagrant ssh -- "sudo cat /var/log/*/error_local.log"
