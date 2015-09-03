class build::php56::supervisor {
  file { '/etc/supervisor/conf.d/php-5.6.conf':
    ensure => present,
    source => 'puppet:///modules/build/etc/supervisor/conf.d/php-5.6.conf',
    mode => 644
  }
}
