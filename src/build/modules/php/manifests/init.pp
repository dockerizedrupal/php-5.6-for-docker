class php {
  require php::packages
  require php::phpfarm
  require php::supervisor

  file { '/phpfarm/src/php-5.6.1.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/php-5.6.1.tar.gz'
  }

  exec { 'tar xzf php-5.6.1.tar.gz':
    cwd => '/phpfarm/src',
    path => ['/bin'],
    require => File['/phpfarm/src/php-5.6.1.tar.gz']
  }

  exec { 'rm php-5.6.1.tar.gz':
    cwd => '/phpfarm/src',
    path => ['/bin'],
    require => Exec['tar xzf php-5.6.1.tar.gz']
  }

  file { '/phpfarm/src/custom/options-5.6.1.sh':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/custom/options-5.6.1.sh',
    mode => 755,
    require => Exec['tar xzf php-5.6.1.tar.gz']
  }

  exec { '/phpfarm/src/main.sh 5.6.1':
    timeout => 0,
    require => File['/phpfarm/src/custom/options-5.6.1.sh']
  }

  exec { 'rm -rf /phpfarm/src/php-5.6.1':
    path => ['/bin'],
    require => Exec['/phpfarm/src/main.sh 5.6.1']
  }

  file { '/phpfarm/inst/php-5.6.1/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.6.1/etc/php-fpm.conf',
    mode => 644,
    require => Exec['/phpfarm/src/main.sh 5.6.1']
  }

  file { '/phpfarm/inst/php-5.6.1/lib/php.ini':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.6.1/lib/php.ini',
    mode => 644,
    require => Exec['/phpfarm/src/main.sh 5.6.1']
  }

  exec { '/bin/bash -l -c "switch-phpfarm 5.6.1"':
    require => Exec['/phpfarm/src/main.sh 5.6.1']
  }
}
