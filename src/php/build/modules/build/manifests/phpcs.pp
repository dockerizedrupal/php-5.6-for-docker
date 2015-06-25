class build::phpcs {
  file { '/tmp/PHP_CodeSniffer-1.5.6.tar.gz':
    ensure => present,
    source => 'puppet:///modules/build/tmp/PHP_CodeSniffer-1.5.6.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf PHP_CodeSniffer-1.5.6.tar.gz':
    require => File['/tmp/PHP_CodeSniffer-1.5.6.tar.gz']
  }

  bash_exec { 'mv /tmp/PHP_CodeSniffer-1.5.6 /usr/local/src/PHP_CodeSniffer_1':
    require => Bash_exec['cd /tmp && tar xzf PHP_CodeSniffer-1.5.6.tar.gz']
  }

  file { '/tmp/PHP_CodeSniffer-2.3.0.tgz':
    ensure => present,
    source => 'puppet:///modules/build/tmp/PHP_CodeSniffer-2.3.0.tgz'
  }

  bash_exec { 'cd /tmp && tar xzf PHP_CodeSniffer-2.3.0.tgz':
    require => File['/tmp/PHP_CodeSniffer-2.3.0.tgz']
  }

  bash_exec { 'mv /tmp/PHP_CodeSniffer-2.3.0 /usr/local/src/PHP_CodeSniffer_2':
    require => Bash_exec['cd /tmp && tar xzf PHP_CodeSniffer-2.3.0.tgz']
  }
}
