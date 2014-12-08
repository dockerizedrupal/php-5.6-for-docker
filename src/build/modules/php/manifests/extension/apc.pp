class php::extension::apc {
  require php

  file { '/tmp/APC-3.1.13.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/APC-3.1.13.tgz'
  }

  exec { 'tar xzf APC-3.1.13.tgz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/APC-3.1.13.tgz']
  }

  exec { 'phpize-5.6.1 apc':
    command => '/phpfarm/inst/bin/phpize-5.6.1',
    cwd => '/tmp/APC-3.1.13',
    require => Exec['tar xzf APC-3.1.13.tgz']
  }

  exec { '/bin/bash -l -c "cd /tmp/APC-3.1.13 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1"':
    timeout => 0,
    require => Exec['phpize-5.6.1 apc']
  }

  exec { '/bin/bash -l -c "cd /tmp/APC-3.1.13 && make"':
    timeout => 0,
    require => Exec['/bin/bash -l -c "cd /tmp/APC-3.1.13 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1"']
  }

  exec { '/bin/bash -l -c "cd /tmp/APC-3.1.13 && make install"':
    timeout => 0,
    require => Exec['/bin/bash -l -c "cd /tmp/APC-3.1.13 && make"']
  }
}
