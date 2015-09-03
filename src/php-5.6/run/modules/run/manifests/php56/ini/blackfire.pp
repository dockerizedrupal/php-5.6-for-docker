class run::php56::ini::blackfire {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/blackfire.ini':
    ensure => present,
    content => template('run/php56/ini/blackfire.ini.erb'),
    mode => 644
  }
}
