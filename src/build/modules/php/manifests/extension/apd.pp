class php::extension::apd {
  require php

  file { '/tmp/pecl-apd-master.zip':
    ensure => present,
    source => 'puppet:///modules/php/tmp/pecl-apd-master.zip'
  }

  exec { 'unzip pecl-apd-master.zip':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => File['/tmp/pecl-apd-master.zip']
  }

  exec { 'phpize-5.6.1 apd':
    command => '/phpfarm/inst/bin/phpize-5.6.1',
    cwd => '/tmp/pecl-apd-master',
    require => Exec['unzip pecl-apd-master.zip']
  }

  exec { '/bin/su - root -mc "cd /tmp/pecl-apd-master && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1"':
    timeout => 0,
    require => Exec['phpize-5.6.1 apd']
  }

  exec { '/bin/su - root -mc "cd /tmp/pecl-apd-master && make"':
    timeout => 0,
    require => Exec['/bin/su - root -mc "cd /tmp/pecl-apd-master && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.6.1"']
  }

  exec { '/bin/su - root -mc "cd /tmp/pecl-apd-master && make install"':
    timeout => 0,
    require => Exec['/bin/su - root -mc "cd /tmp/pecl-apd-master && make"']
  }
}
