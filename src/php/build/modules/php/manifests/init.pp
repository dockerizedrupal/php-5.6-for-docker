class php {
  require php::packages
  require php::phpfarm
  require php::supervisor
  require php::freetds

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.6.1/etc/conf.d': }

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.6.1/lib/php/extensions/no-debug-non-zts-20131226': }

  file { '/tmp/php-5.6.1.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/php-5.6.1.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf php-5.6.1.tar.gz':
    require => File['/tmp/php-5.6.1.tar.gz']
  }

  bash_exec { 'mv /tmp/php-5.6.1 /usr/local/src/phpfarm/src/php-5.6.1':
    require => Bash_exec['cd /tmp && tar xzf php-5.6.1.tar.gz']
  }

  file { '/usr/local/src/phpfarm/src/custom/options-5.6.1.sh':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/custom/options-5.6.1.sh',
    mode => 755,
    require => Bash_exec['mv /tmp/php-5.6.1 /usr/local/src/phpfarm/src/php-5.6.1']
  }

  bash_exec { '/usr/local/src/phpfarm/src/main.sh 5.6.1':
    timeout => 0,
    require => File['/usr/local/src/phpfarm/src/custom/options-5.6.1.sh']
  }

  bash_exec { 'rm -rf /usr/local/src/phpfarm/src/php-5.6.1':
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.6.1']
  }

  file { '/usr/local/src/phpfarm/inst/php-5.6.1/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.6.1/etc/php-fpm.conf',
    mode => 644,
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.6.1']
  }

  bash_exec { 'switch-phpfarm 5.6.1':
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.6.1']
  }
}
