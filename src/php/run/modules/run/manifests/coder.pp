class run::coder {
  require run::user

  if $drupal_version == '7' {
    file { '/home/container/.drush/coder':
      ensure => link,
      target => '/usr/local/src/coder7'
    }

    file { '/usr/local/src/PHP_CodeSniffer_1/CodeSniffer/Standards/Drupal':
      ensure => link,
      target => '/usr/local/src/coder7/coder_sniffer/Drupal'
    }
  }
  elsif $drupal_version == '8' {
    file { '/home/container/.drush/coder':
      ensure => link,
      target => '/usr/local/src/coder8'
    }

    file { '/usr/local/src/PHP_CodeSniffer_2/CodeSniffer/Standards/Drupal':
      ensure => link,
      target => '/usr/local/src/coder8/coder_sniffer/Drupal'
    }
  }
}
