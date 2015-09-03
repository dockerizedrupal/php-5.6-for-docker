class build::php56::extensions {
  require build::php56

  include build::php56::extension::xdebug
  include build::php56::extension::memcached
  include build::php56::extension::redis
  include build::php56::extension::blackfire
  include build::php56::extension::apcu
  include build::php56::extension::apd
}
