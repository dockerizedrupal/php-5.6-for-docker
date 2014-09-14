docker-php-5.5.15
=================

Run the container
-----------------

    sudo docker run \
      --name php5515 \
      -p 127.0.0.1::22 \
      -p 0.0.0.0:5515:9000 \
      --volumes-from apache \
      -d \
      simpledrupalcloud/php:5.5.15

Build the image
---------------

    git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git docker-php
    cd docker-php
    git checkout 5.5.15
    sudo docker build -t simpledrupalcloud/php:5.5.15 .