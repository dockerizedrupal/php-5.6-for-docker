class build::drupal_console {
  file { '/usr/local/bin/drupal':
    ensure => present,
    source => 'puppet:///modules/build/tmp/drupal.phar',
    mode => 755
  }
}
