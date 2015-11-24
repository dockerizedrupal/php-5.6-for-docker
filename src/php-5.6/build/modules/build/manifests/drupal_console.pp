class build::drupal_console {
  file { '/usr/local/bin/drupal':
    ensure => present,
    source => 'puppet:///modules/build/tmp/console.phar',
    mode => 755
  }
}
