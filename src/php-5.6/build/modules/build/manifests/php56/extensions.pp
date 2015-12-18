class build::php56::extensions {
  require build::php56

  include build::php56::extensions::xdebug
  include build::php56::extensions::memcached
  include build::php56::extensions::redis
  include build::php56::extensions::blackfire
  include build::php56::extensions::apcu
  include build::php56::extensions::apd
}
