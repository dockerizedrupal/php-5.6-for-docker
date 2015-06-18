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
      -e TIMEZONE="UTC" \
      -e POST_MAX_SIZE="512M" \
      -e UPLOAD_MAX_FILESIZE="512M" \
      -e SHORT_OPEN_TAG="1" \
      -e MAX_EXECUTION_TIME="300" \
      -e MAX_INPUT_VARS="4096" \
      -e MEMORY_LIMIT="512M" \
      -e OPCACHE="1" \
      -e XDEBUG="1" \
      -e MEMCACHED="1" \
      -e REDIS="1" \
      -e BLACKFIRE="1" \
      -e APCU="1" \
      -e APD="1" \
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

## License

**MIT**
