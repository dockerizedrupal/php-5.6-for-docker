class run::php56::ini::memcached {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/memcached.ini':
    ensure => present,
    content => template('run/php56/ini/memcached.ini.erb'),
    mode => 644
  }
}
