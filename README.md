# docker-php

A [Docker](https://docker.com/) container for [PHP](http://php.net/) version 5.6 that runs PHP in FPM (FastCGI Process Manager) mode.

Configuration, PHP extensions and other tools built into the image are primarily aimed for the developers that are using [Drupal](https://www.drupal.org/) as their primary development framework.

## Run the container

Using the `docker` command:

    CONTAINER="php" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 9000:9000 \
      -e SERVER_NAME="localhost" \
      -e DRUPAL_VERSION="8" \
      -e PHP_INI_REALPATH_CACHE_SIZE="256k" \
      -e PHP_INI_REALPATH_CACHE_TTL="3600" \
      -e PHP_INI_POST_MAX_SIZE="512M" \
      -e PHP_INI_TIMEZONE="UTC" \
      -e PHP_INI_UPLOAD_MAX_FILESIZE="512M" \
      -e PHP_INI_SHORT_OPEN_TAG="On" \
      -e PHP_INI_MAX_EXECUTION_TIME="300" \
      -e PHP_INI_MAX_INPUT_VARS="4096" \
      -e PHP_INI_MEMORY_LIMIT="512M" \
      -e PHP_INI_DISPLAY_ERRORS="On" \
      -e PHP_INI_DISPLAY_STARTUP_ERRORS="On" \
      -e PHP_INI_ERROR_REPORTING="E_ALL" \
      -e PHP_INI_EXPOSE_PHP="On" \
      -e PHP_INI_ALLOW_URL_FOPEN="On" \
      -e PHP_INI_OPCACHE="On" \
      -e PHP_INI_OPCACHE_MEMORY_CONSUMPTION="2048" \
      -e PHP_INI_XDEBUG="On" \
      -e PHP_INI_XDEBUG_REMOTE_PORT="9000" \
      -e PHP_INI_XDEBUG_REMOTE_HOST="127.0.0.1" \
      -e PHP_INI_XDEBUG_REMOTE_CONNECT_BACK="On" \
      -e PHP_INI_XDEBUG_IDEKEY="PHPSTORM" \
      -e PHP_INI_MEMCACHED="On" \
      -e PHP_INI_REDIS="On" \
      -e PHP_INI_BLACKFIRE="On" \
      -e PHP_INI_BLACKFIRE_SERVER_ID="" \
      -e PHP_INI_BLACKFIRE_SERVER_TOKEN="" \
      -e PHP_INI_APCU="On" \
      -e PHP_INI_APD="On" \
      -e PHP_FPM_PM="dynamic" \
      -e PHP_FPM_PM_MAX_CHILDREN="5" \
      -e PHP_FPM_PM_START_SERVERS="2" \
      -e PHP_FPM_PM_MIN_SPARE_SERVERS="1" \
      -e PHP_FPM_PM_MAX_SPARE_SERVERS="3" \
      -e PHP_FPM_PM_PROCESS_IDLE_TIMEOUT="10s" \
      -e PHP_FPM_PM_MAX_REQUESTS="0" \
      -e USER_ID="" \
      -e GROUP_ID="" \
      -d \
      viljaste/php:5.6

Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.6 \
      && sudo docker-compose up

## Build the image

    TMP="$(mktemp -d)" \
      && GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.6 \
      && sudo docker build -t viljaste/php:5.6 . \
      && cd -

## Tests

Tests are implemented in [Bats: Bash Automated Testing System](https://github.com/sstephenson/bats).

### Test results for the current release

    1..75
    ok 1 php
    ok 2 php: drupal 7
    ok 3 php: drupal 7: drush 7
    ok 4 php: drupal 7: phpcs
    ok 5 php: drupal 7: phpcs: phpcompatibility
    ok 6 php: drupal 7: phpcs: drupal
    ok 7 php: drupal 8
    ok 8 php: drupal 8: drush 8
    ok 9 php: drupal 8: phpcs
    ok 10 php: drupal 8: phpcs: phpcompatibility
    ok 11 php: drupal 8: phpcs: drupal
    ok 12 php: fpm: pm
    ok 13 php: fpm: pm.max_children
    ok 14 php: fpm: pm.max_requests
    ok 15 php: fpm: pm.max_spare_servers
    ok 16 php: fpm: pm.min_spare_servers
    ok 17 php: fpm: pm.process_idle_timeout
    ok 18 php: fpm: pm.start_servers
    ok 19 php: freetds: FREETDS_1_SERVER_NAME
    ok 20 php: freetds: FREETDS_1_HOST
    ok 21 php: freetds: FREETDS_1_PORT
    ok 22 php: freetds: FREETDS_1_TDS_VERSION
    ok 23 php: freetds: FREETDS_2_SERVER_NAME
    ok 24 php: freetds: FREETDS_2_HOST
    ok 25 php: freetds: FREETDS_2_PORT
    ok 26 php: freetds: FREETDS_2_TDS_VERSION
    ok 27 php: freetds: FREETDS_3_SERVER_NAME
    ok 28 php: freetds: FREETDS_3_HOST
    ok 29 php: freetds: FREETDS_3_PORT
    ok 30 php: freetds: FREETDS_3_TDS_VERSION
    ok 31 php: ini: allow_url_fopen: off
    ok 32 php: ini: allow_url_fopen: on
    ok 33 php: ini: apcu: off
    ok 34 php: ini: apcu: on
    ok 35 php: ini: apd: off
    ok 36 php: ini: apd: on
    ok 37 php: ini: blackfire: off
    ok 38 php: ini: blackfire: on
    ok 39 php: ini: blackfire.server_id
    ok 40 php: ini: blackfire.server_token
    ok 41 php: ini: display_errors: off
    ok 42 php: ini: display_errors: on
    ok 43 php: ini: display_startup_errors: off
    ok 44 php: ini: display_startup_errors: on
    ok 45 php: ini: error_reporting
    ok 46 php: ini: expose_php: off
    ok 47 php: ini: expose_php: on
    ok 48 php: ini: igbinary: on
    ok 49 php: ini: max_execution_time
    ok 50 php: ini: max_input_vars
    ok 51 php: ini: memcached: off
    ok 52 php: ini: memcached: on
    ok 53 php: ini: memory_limit
    ok 54 php: ini: mssql: on
    ok 55 php: ini: opcache.memory_consumption
    ok 56 php: ini: opcache: off
    ok 57 php: ini: opcache: on
    ok 58 php: ini: post_max_size
    ok 59 php: ini: realpath_cache_size
    ok 60 php: ini: realpath_cache_ttl
    ok 61 php: ini: redis
    ok 62 php: ini: redis
    ok 63 php: ini: short_open_tag: off
    ok 64 php: ini: short_open_tag: on
    ok 65 php: ini: timezone
    ok 66 php: ini: upload_max_filesize
    ok 67 php: ini: xdebug.idekey
    ok 68 php: ini: xdebug: off
    ok 69 php: ini: xdebug: on
    ok 70 php: ini: xdebug.remote_connect_back: on
    ok 71 php: ini: xdebug.remote_connect_back: on
    ok 72 php: ini: xdebug.remote_host
    ok 73 php: ini: xdebug.remote_port
    ok 74 php: smtp: off
    ok 75 php: smtp: on

## License

**MIT**
