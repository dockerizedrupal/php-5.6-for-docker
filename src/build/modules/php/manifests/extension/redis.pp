class php::extension::redis {
  require php
  require php::extension::igbinary

  file { '/tmp/redis-2.2.5.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/redis-2.2.5.tgz'
  }

  exec { 'cd /tmp && tar xzf redis-2.2.5.tgz':
    require => File['/tmp/redis-2.2.5.tgz']
  }

  exec { 'cd /tmp/redis-2.2.5 && phpize-5.6.1':
    require => Exec['cd /tmp && tar xzf redis-2.2.5.tgz']
  }

  exec { 'cd /tmp/redis-2.2.5 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1 --enable-redis-igbinary':
    timeout => 0,
    require => Exec['cd /tmp/redis-2.2.5 && phpize-5.6.1']
  }

  exec { 'cd /tmp/redis-2.2.5 && make':
    timeout => 0,
    require => Exec['cd /tmp/redis-2.2.5 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1 --enable-redis-igbinary']
  }

  exec { 'cd /tmp/redis-2.2.5 && make install':
    timeout => 0,
    require => Exec['cd /tmp/redis-2.2.5 && make']
  }
}
