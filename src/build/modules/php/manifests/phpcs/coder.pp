class php::phpcs::coder {
  require php::phpcs

  exec { '/bin/su - root -mc "drush dl coder --destination=/root/.drush"':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => File['/tmp/PHPCompatibility-master.zip']
  }

  file { '/tmp/coder-7.x-2.4.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/coder-7.x-2.4.tar.gz'
  }

  exec { 'tar xzf coder-7.x-2.4.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/coder-7.x-2.4.tar.gz']
  }

  exec { 'mv /tmp/coder /root/.drush/coder':
    path => ['/bin'],
    require => Exec['tar xzf coder-7.x-2.4.tar.gz']
  }
}
