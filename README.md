docker-php-5.5.15
=================

Run the container
-----------------

    CONTAINER=php55 && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 5515:5515
      -v /var/www:/var/www \
      -d \
      simpledrupalcloud/php:5.5.15

Build the image
---------------

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.5.15 \
      && sudo docker build -t simpledrupalcloud/php:5.5.15 . \
      && cd -

Apache directives
-----------------

    <IfModule mod_fastcgi.c>
      AddHandler php .php

      Alias /php55 /var/www/php55
      FastCgiExternalServer /var/www/php55 -host 127.0.0.1:5515 -idle-timeout 300 -pass-header Authorization

      <Location /php55>
        Order deny,allow
        Deny from all
        Allow from env=REDIRECT_STATUS
      </Location>

      Action php /php55
    </IfModule>