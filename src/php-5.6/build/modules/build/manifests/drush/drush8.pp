class build::drush::drush8 {
  require build::user
  require build::php56
  require build::php56::extensions
  require build::composer
  require build::drush::packages

  file { '/tmp/drush-8.1.3.tar.gz':
    ensure => present,
    source => 'puppet:///modules/build/tmp/drush-8.1.3.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf drush-8.1.3.tar.gz':
    require => File['/tmp/drush-8.1.3.tar.gz']
  }

  bash_exec { 'mv /tmp/drush-8.1.3 /usr/local/src/drush8':
    require => Bash_exec['cd /tmp && tar xzf drush-8.1.3.tar.gz']
  }

  bash_exec { 'cd /usr/local/src/drush8 && composer install':
    timeout => 0,
    require => Bash_exec['mv /tmp/drush-8.1.3 /usr/local/src/drush8']
  }
}
