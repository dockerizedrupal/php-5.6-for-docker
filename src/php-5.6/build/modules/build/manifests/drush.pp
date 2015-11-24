class build::drush {
  require build::user
  require build::php56
  require build::php56::extensions
  require build::composer
  require build::drush::packages

  bash_exec { "su - container -c 'mkdir /home/container/.drush'": }

  include build::drush::drush5
  include build::drush::drush6
  include build::drush::drush7
  include build::drush::drush8
}
