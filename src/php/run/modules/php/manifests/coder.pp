class php::coder {
  if $drupal_version == '7' {
    file { '/root/.drush/coder':
      ensure => link,
      target => '/usr/local/src/coder7'
    }

    file { '/usr/local/src/PHP_CodeSniffer_1/CodeSniffer/Standards/Drupal':
      ensure => link,
      target => '/usr/local/src/coder7/coder_sniffer/Drupal'
    }
  }
  elsif $drupal_version == '8' {
    file { '/root/.drush/coder':
      ensure => link,
      target => '/usr/local/src/coder8'
    }

    file { '/usr/local/src/PHP_CodeSniffer_2/CodeSniffer/Standards/Drupal':
      ensure => link,
      target => '/usr/local/src/coder8/coder_sniffer/Drupal'
    }
  }
}
