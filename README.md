# docker-php

A [Docker](https://docker.com/) container for [PHP](http://php.net/) version 5.6.1 that runs PHP in FPM (FastCGI Process Manager) mode.

PHP configuration, extensions and tools built into the image are primarily aimed for the developers that use [Drupal](https://www.drupal.org/) as their primary development framework.

## Run the container

Using the `docker` command:

    CONTAINER="httpddata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /httpd/data \
      simpledrupalcloud/httpddata:dev

    CONTAINER="php56" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 9000:9000 \
      --volumes-from httpddata \
      -d \
      simpledrupalcloud/php:5.6-dev

Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.6-dev \
      && sudo fig up

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.6-dev \
      && sudo docker build -t simpledrupalcloud/php:5.6-dev . \
      && cd -

## Apache directives

    <IfModule mod_fastcgi.c>
      AddHandler php .php

      Alias /php56 /httpd/php56
      FastCgiExternalServer /httpd/php56 -host 127.0.0.1:9000 -idle-timeout 300 -pass-header Authorization

      <Location /php56>
        Order deny,allow
        Deny from all
        Allow from env=REDIRECT_STATUS
      </Location>

      Action php /php56
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

[PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer) is included with the image to help you ensure that your PHP code remains clean and consistent.

#### PHPCompatibility

[PHPCompatibility](https://github.com/wimg/PHPCompatibility) sniffs for PHP_CodeSniffer have been added to the image.

PHPCompatibility allows you to check the compatibility of your PHP code to different PHP versions.

#### Coder

Since this image is mostly oriented towards users that use Drupal as their primary development framework, there is also a tool called [Coder](https://www.drupal.org/project/coder) available to use.

Coder helps you to ensure that your PHP code is written against Drupal's coding standards and best practices.

### Drush

[Drush](https://github.com/drush-ops/drush) is built into the image.

There is also a wrapper script `tools/drush.sh` that allows you to use Drush directly from your host to communicate with the Drush that lives inside the container.

#### Performance graph

A graph comparing the execution times of Drush when running it from inside the container and outside the container.

![drush_graph](/drush_graph.png)

The command that were used to do the test is:

    for i in $(seq 1 20); do time bash -c "drush -y en views && drush -y dis views && drush -y pm-uninstall views"; sleep 1; done
    
Keep in mind that Drush was executed three times in each test.

This means that the average execution time difference displayed on the graph between native Drush and the wrapper script could be narrowed down at least three times, which is approximately 0.5 seconds.

## License

**MIT**
