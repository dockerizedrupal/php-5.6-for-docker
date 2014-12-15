class php::extension::blackfire {
  require php

  exec { 'mkdir -p /var/run/blackfire':
    path => ['/bin']
  }

  file { '/phpfarm/inst/php-5.6.1/lib/php/extensions/no-debug-non-zts-20131226/blackfire-php-linux_amd64-php-56.so':
    ensure => present,
    source => 'puppet:///modules/php/tmp/blackfire-php-linux_amd64-php-56.so'
  }

  file { '/usr/local/bin/blackfire-agent-linux_amd64':
    ensure => present,
    source => 'puppet:///modules/php/tmp/blackfire-agent-linux_amd64',
    mode => 755
  }
}
