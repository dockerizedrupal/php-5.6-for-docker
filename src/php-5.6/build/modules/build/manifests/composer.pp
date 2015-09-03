class build::composer {
  require build::php56

  bash_exec { 'curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename composer':
    timeout => 0
  }
}
