#!/usr/bin/env bash

case "${1}" in
  build)
    /bin/su - root -mc "apt-get update && /src/php-5.6/build.sh && /src/php-5.6/clean.sh"
    ;;
  run)
    /bin/su - root -mc "source /src/php-5.6/variables.sh && /src/php-5.6/run.sh"
    ;;
esac
