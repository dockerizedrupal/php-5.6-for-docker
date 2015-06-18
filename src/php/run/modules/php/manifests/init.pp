class php {
  include php::smtp
  include php::drush
  include php::coder
  include php::phpcs

  include php::timezone
  include php::post_max_size
  include php::upload_max_filesize
  include php::short_open_tag
  include php::max_execution_time
  include php::max_input_vars
  include php::memory_limit

  if $mysqld_host {
    include php::mysqld
  }

  if $freetds_1_server_name {
    include php::freetds
  }

  if $opcache {
    include php::opcache
  }

  if $xdebug {
    include php::xdebug
  }

  include php::memcached
  include php::redis

  if $blackfire {
    include php::blackfire
  }

  if $apcu {
    include php::apcu
  }

  if $apd {
    include php::apd
  }

  file { '/root/.bashrc':
    ensure => present,
    content => template('php/.bashrc.erb')
  }
}
