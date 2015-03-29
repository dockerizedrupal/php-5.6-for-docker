class php::extension::apd {
  require php

  file { '/tmp/pecl-apd-master.zip':
    ensure => present,
    source => 'puppet:///modules/php/tmp/pecl-apd-master.zip'
  }

  bash_exec { 'cd /tmp && unzip pecl-apd-master.zip':
    require => File['/tmp/pecl-apd-master.zip']
  }

  bash_exec { 'cd /tmp/pecl-apd-master && phpize-5.6.1':
    require => Bash_exec['cd /tmp && unzip pecl-apd-master.zip']
  }

  bash_exec { 'cd /tmp/pecl-apd-master && ./configure --with-php-config=/usr/local/src/phpfarm/inst/bin/php-config-5.6.1':
    timeout => 0,
    require => Bash_exec['cd /tmp/pecl-apd-master && phpize-5.6.1']
  }

  bash_exec { 'cd /tmp/pecl-apd-master && make':
    timeout => 0,
    require => Bash_exec['cd /tmp/pecl-apd-master && ./configure --with-php-config=/usr/local/src/phpfarm/inst/bin/php-config-5.6.1']
  }

  bash_exec { 'cd /tmp/pecl-apd-master && make install':
    timeout => 0,
    require => Bash_exec['cd /tmp/pecl-apd-master && make']
  }
}
