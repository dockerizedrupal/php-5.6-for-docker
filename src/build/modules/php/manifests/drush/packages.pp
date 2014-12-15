class php::drush::packages {
  require php

  exec { 'curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename composer': }

  package {[
      'build-essential',
      'libxml2-dev',
      'libssl-dev',
      'libbz2-dev',
      'libcurl4-openssl-dev',
      'libjpeg-dev',
      'libpng12-dev',
      'libmcrypt-dev',
      'libmhash-dev',
      'libmysqlclient-dev',
      'libpspell-dev',
      'autoconf',
      'libcloog-ppl0',
      'libsasl2-dev',
      'libldap2-dev',
      'ssmtp'
    ]:
    ensure => present
  }
}
