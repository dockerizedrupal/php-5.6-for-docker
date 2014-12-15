class php::drush {
  require php
  require php::drush::packages

  exec { '/bin/bash -c "echo \'export PATH="${HOME}/.composer/vendor/bin:${PATH}"\' >> ${HOME}/.bashrc"': }

  exec { '/bin/bash -c "source ${HOME}/.bashrc && composer global require drush/drush:6.*"':
    require => '/bin/bash -c "echo \'export PATH="${HOME}/.composer/vendor/bin:${PATH}"\' >> ${HOME}/.bashrc"';
  }
}
