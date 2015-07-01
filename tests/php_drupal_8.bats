#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php_drupal_8.yml"

container() {
  echo "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps php | grep php | awk '{ print $1 }')"
}

setup_drupal() {
  docker exec "$(container)" /bin/su - root -lc "wget http://ftp.drupal.org/files/projects/drupal-8.0.0-beta12.tar.gz -O /tmp/drupal-8.0.0-beta12.tar.gz"
  docker exec "$(container)" /bin/su - root -lc "tar xzf /tmp/drupal-8.0.0-beta12.tar.gz -C /tmp"
  docker exec "$(container)" /bin/su - root -lc "rsync -avz /tmp/drupal-8.0.0-beta12/ /httpd/data"
  docker exec "$(container)" /bin/su - root -lc "cp /httpd/data/sites/default/default.services.yml /httpd/data/sites/default/services.yml"
  docker exec "$(container)" /bin/su - root -lc "drush -r /httpd/data -y site-install --db-url=mysqli://root:root@localhost/drupal --account-name=admin --account-pass=admin"
  docker exec "$(container)" /bin/su - root -lc "chown container.container /httpd/data"
}

setup() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" up -d --allow-insecure-ssl

  sleep 10

  setup_drupal
}

teardown() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" kill
  docker-compose -f "${DOCKER_COMPOSE_FILE}" rm --force
}

@test "php: drupal 8" {
  run docker exec "$(container)" /bin/su - root -lc "drush -r /httpd/data/ status | grep 'Drupal bootstrap'"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"Successful"* ]]
}

@test "php: drupal 8: drush 8" {
  run docker exec "$(container)" /bin/su - root -lc "drush --version"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"8.0-dev"* ]]
}

@test "php: drupal 8: phpcs" {
  run docker exec "$(container)" /bin/su - root -lc "phpcs --version"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"2.3.0"* ]]
}

@test "php: drupal 8: phpcs: phpcompatibility" {
  run docker exec "$(container)" /bin/su - root -lc "phpcs -i | grep 'PHPCompatibility'"

  [ "${status}" -eq 0 ]
}

@test "php: drupal 8: phpcs: drupal" {
  run docker exec "$(container)" /bin/su - root -lc "phpcs -i | grep 'Drupal'"

  [ "${status}" -eq 0 ]
}
