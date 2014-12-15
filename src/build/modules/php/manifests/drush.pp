class php::drush {
  require php
  require php::drush::packages

  file { '/root/.bashrc':
    ensure => present,
    source => 'puppet:///modules/php/root/.bashrc',
    mode => 644
  }

  exec { '/bin/bash -l -c "source ~/.bashrc && composer global require drush/drush:6.*"':
    timeout => 0,
    require => File['/root/.bashrc']
  }
}
