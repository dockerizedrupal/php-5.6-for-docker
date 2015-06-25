class run::drush {
  if ($drupal_version == '7') or ($drupal_version == '8') {
    file { '/usr/local/bin/drush':
      ensure => link,
      target => '/usr/local/src/drush7/drush'
    }

    file { '/etc/bash_completion.d/drush.complete.sh':
      ensure => link,
      target => '/usr/local/src/drush7/drush.complete.sh'
    }
  }
}
