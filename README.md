# docker-php

A [Docker](https://docker.com/) container for [PHP](http://php.net/) version 5.6.1 that runs PHP in FPM (FastCGI Process Manager) mode.

Condocker-composeuration, PHP extensions and other tools built into the image are primarily aimed for the developers that are using [Drupal](https://www.drupal.org/) as their primary development framework.

## Run the container

Using the `docker` command:

    CONTAINER="php" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 9000:9000 \
      -d \
      viljaste/php:5.6-dev

Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.6-dev \
      && sudo docker-compose up

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.6-dev \
      && sudo docker build -t viljaste/php:5.6-dev . \
      && cd -

## Apache directives

    <IfModule mod_fastcgi.c>
      AddHandler php .php

      Alias /php /httpd/php
      FastCgiExternalServer /httpd/php -host 127.0.0.1:9000 -idle-timeout 300 -pass-header Authorization

      <Location /php>
        Order deny,allow
        Deny from all
        Allow from env=REDIRECT_STATUS
      </Location>

      Action php /php
    </IfModule>

## PHP extensions

PHP extensions compiled into the image.

* [APCu 4.0.7](http://pecl.php.net/package/APCu)
* [Blackfire](https://blackfire.io/)
* [igbinary 1.2.1](http://pecl.php.net/package/igbinary)
* [memcached 2.2.0](http://pecl.php.net/package/memcached)
* [apd 1.0.2-dev](https://github.com/ZeWaren/pecl-apd)
* [redis 2.2.5](http://pecl.php.net/package/redis)
* [xdebug 2.2.6](http://pecl.php.net/package/Xdebug)

## Tools

### PHP_CodeSniffer

[PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer) is a tool that helps you to ensure that your PHP code remains clean and consistent.

### PHPCompatibility

[PHPCompatibility](https://github.com/wimg/PHPCompatibility) is a set of sniffs for PHP_CodeSniffer.

PHPCompatibility allows you to check the compatibility of your PHP code to different PHP versions.

### Coder

Since this image is mostly oriented towards users that use Drupal as their primary development framework, there is also a tool called [Coder](https://www.drupal.org/project/coder) available to use.

Coder helps you to ensure that your PHP code is written against Drupal's coding standards and best practices.

### Drush

Every Drupal developer should know what [Drush](https://github.com/drush-ops/drush) is.

There are three versions (5.11.0, 6.5.0 and 7.0.0-alpha8) of Drush built into this image.

You can choose upon starting the container by passing a corresponding environment variable `DRUSH_VERSION=5|6|7` which version should be the default for Drush.

There is also a wrapper script `tools/drush.sh` that allows you to use Drush directly from your host to communicate with the native Drush that lives inside the container.

The wrapper script for Drush also can help you set up a fully working development environment, which consists of multiple Docker containers.

The services that it currently knows about are:

* Apache HTTP server
* MySQL database server
* PHP-FPM
* Memcache
* phpMyAdmin
* Adminer
* Mailcatcher

#### Performance graph

A graph comparing the execution times of Drush when running it from inside the container and from outside the container.

![drush_graph](/drush_graph.png)

The command that was used to do the test is following:

    for i in $(seq 1 20); do time bash -c "drush -y en views && drush -y dis views && drush -y pm-uninstall views"; sleep 1; done

Keep in mind that Drush was executed three times in a single test.

This means that the average execution time difference displayed on the graph between native Drush and the wrapper script could be narrowed down at least three times, which makes the end result approximately 0.5 seconds.

All tests were run on a DigitalOcean server with 8GB of RAM.

## License

**MIT**
