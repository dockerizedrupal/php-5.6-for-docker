class build::phpcs::coder {
  file { '/tmp/coder-7.x-2.5.tar.gz':
    ensure => present,
    source => 'puppet:///modules/build/tmp/coder-7.x-2.5.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf coder-7.x-2.5.tar.gz':
    require => File['/tmp/coder-7.x-2.5.tar.gz']
  }

  bash_exec { 'mv /tmp/coder /usr/local/src/coder7':
    require => Bash_exec['cd /tmp && tar xzf coder-7.x-2.5.tar.gz']
  }

  bash_exec { 'rm -rf /tmp/coder':
    require => Bash_exec['mv /tmp/coder /usr/local/src/coder7']
  }

  file { '/tmp/coder-8.x-2.3.tar.gz':
    ensure => present,
    source => 'puppet:///modules/build/tmp/coder-8.x-2.3.tar.gz',
    require => Bash_exec['rm -rf /tmp/coder']
  }

  bash_exec { 'cd /tmp && tar xzf coder-8.x-2.3.tar.gz':
    require => File['/tmp/coder-8.x-2.3.tar.gz']
  }

  bash_exec { 'mv /tmp/coder /usr/local/src/coder8':
    require => Bash_exec['cd /tmp && tar xzf coder-8.x-2.3.tar.gz']
  }
}
