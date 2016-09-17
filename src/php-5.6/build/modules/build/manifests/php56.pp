class build::php56 {
  require build::php56::packages
  require build::php56::supervisor
  require build::phpfarm
  require build::freetds

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.6.26/etc/conf.d': }

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.6.26/etc/fpm.d': }

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.6.26/etc/pool.d': }

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.6.26/lib/php/extensions/no-debug-non-zts-20131226': }

  file { '/tmp/php-5.6.26.tar.gz':
    ensure => present,
    source => 'puppet:///modules/build/tmp/php-5.6.26.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf php-5.6.26.tar.gz':
    require => File['/tmp/php-5.6.26.tar.gz']
  }

  bash_exec { 'mv /tmp/php-5.6.26 /usr/local/src/phpfarm/src/php-5.6.26':
    require => Bash_exec['cd /tmp && tar xzf php-5.6.26.tar.gz']
  }

  file { '/usr/local/src/phpfarm/src/custom/options-5.6.26.sh':
    ensure => present,
    source => 'puppet:///modules/build/usr/local/src/phpfarm/src/custom/options-5.6.26.sh',
    mode => 755,
    require => Bash_exec['mv /tmp/php-5.6.26 /usr/local/src/phpfarm/src/php-5.6.26']
  }

  bash_exec { '/usr/local/src/phpfarm/src/main.sh 5.6.26':
    timeout => 0,
    require => File['/usr/local/src/phpfarm/src/custom/options-5.6.26.sh']
  }

  bash_exec { 'rm -rf /usr/local/src/phpfarm/src/php-5.6.26':
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.6.26']
  }

  file { '/usr/local/src/phpfarm/inst/php-5.6.26/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/build/usr/local/src/phpfarm/inst/php-5.6.26/etc/php-fpm.conf',
    mode => 644,
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.6.26']
  }

  bash_exec { 'switch-phpfarm 5.6.26':
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.6.26']
  }
}
