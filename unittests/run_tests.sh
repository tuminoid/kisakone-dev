#!/bin/bash

run-phpunit() {
    echo "Testing: $*"
    phpunit --colors --strict "$@"
}


run-phpunit ./testLogin.php
run-phpunit ./testUrl.php
