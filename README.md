docker-php-5.6.0
=================

Run the container
-----------------

    CONTAINER=php56 && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 5600:5600
      -v /var/www:/var/www \
      -d \
      simpledrupalcloud/php:5.6.0

Build the image
---------------

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.6.0 \
      && sudo docker build -t simpledrupalcloud/php:5.6.0 . \
      && cd -

Apache directives
-----------------

    <IfModule mod_fastcgi.c>
      AddHandler php .php

      Alias /php56 /var/www/php56
      FastCgiExternalServer /var/www/php56 -host 127.0.0.1:5600 -idle-timeout 300 -pass-header Authorization

      <Location /php56>
        Order deny,allow
        Deny from all
        Allow from env=REDIRECT_STATUS
      </Location>

      Action php /php56
    </IfModule>
