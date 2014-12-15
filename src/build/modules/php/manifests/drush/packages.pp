class php::drush::packages {
  require php

  exec { 'curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename composer': }
}
