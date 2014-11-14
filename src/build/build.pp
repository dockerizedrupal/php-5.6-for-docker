node default {
  include php
  include php::extension::xdebug

  include mysql
  include ssmtp
}
