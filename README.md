docker-php-5.5.15
=================

Run the container
-----------------

    sudo docker run \
      --name php \
      --net host \
      --volumes-from apache \
      -d \
      simpledrupalcloud/php:5.5.15

Build the image yourself
------------------------

    git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git docker-php
    cd docker-php
    git checkout 5.5.15
    sudo docker build -t php:5.5.15 .