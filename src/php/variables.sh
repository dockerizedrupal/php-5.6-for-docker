#!/usr/bin/env bash

if [ -z "${SERVER_NAME}" ]; then
  SERVER_NAME="localhost"
fi

export FACTER_SERVER_NAME="${SERVER_NAME}"

SMTP_PORT="$(echo "${SMTP_PORT}" | sed 's/tcp:\/\///')"

export FACTER_SMTP_HOST="$(echo "${SMTP_PORT}" | cut -d ":" -f1)"
export FACTER_SMTP_PORT="$(echo "${SMTP_PORT}" | cut -d ":" -f2)"

MYSQLD_HOST="$(echo "${MYSQLD_PORT}" | sed 's/tcp:\/\///')"

export FACTER_MYSQLD_HOST="$(echo "${MYSQLD_HOST}" | cut -d ":" -f1)"
export FACTER_MYSQLD_PORT="$(echo "${MYSQLD_HOST}" | cut -d ":" -f2)"

MEMCACHED_HOST="$(echo "${MEMCACHED_PORT}" | sed 's/tcp:\/\///')"

export FACTER_MEMCACHED_HOST="$(echo "${MEMCACHED_HOST}" | cut -d ":" -f1)"
export FACTER_MEMCACHED_PORT="$(echo "${MEMCACHED_HOST}" | cut -d ":" -f2)"

REDIS_HOST="$(echo "${REDIS_PORT}" | sed 's/tcp:\/\///')"

export FACTER_REDIS_HOST="$(echo "${REDIS_HOST}" | cut -d ":" -f1)"
export FACTER_REDIS_PORT="$(echo "${REDIS_HOST}" | cut -d ":" -f2)"

if [ -z "${DRUPAL_VERSION}" ]; then
  DRUPAL_VERSION="8"
fi

export FACTER_DRUPAL_VERSION="${DRUPAL_VERSION}"

if [ -z "${TIMEZONE}" ]; then
  TIMEZONE="UTC"
fi

export FACTER_TIMEZONE="${TIMEZONE}"

if [ -z "${POST_MAX_SIZE}" ]; then
  POST_MAX_SIZE="512M"
fi

export FACTER_POST_MAX_SIZE="${POST_MAX_SIZE}"

if [ -z "${UPLOAD_MAX_FILESIZE}" ]; then
  UPLOAD_MAX_FILESIZE="512M"
fi

export FACTER_UPLOAD_MAX_FILESIZE="${UPLOAD_MAX_FILESIZE}"

if [ -z "${SHORT_OPEN_TAG}" ]; then
  SHORT_OPEN_TAG="1"
fi

export FACTER_SHORT_OPEN_TAG="${SHORT_OPEN_TAG}"

if [ -z "${MAX_EXECUTION_TIME}" ]; then
  MAX_EXECUTION_TIME="300"
fi

export FACTER_MAX_EXECUTION_TIME="${MAX_EXECUTION_TIME}"

if [ -z "${MAX_INPUT_VARS}" ]; then
  MAX_INPUT_VARS="4096"
fi

export FACTER_MAX_INPUT_VARS="${MAX_INPUT_VARS}"

if [ -z "${MEMORY_LIMIT}" ]; then
  MEMORY_LIMIT="512M"
fi

export FACTER_MEMORY_LIMIT="${MEMORY_LIMIT}"

if [ -z "${OPCACHE}" ]; then
  OPCACHE="1"
fi

export FACTER_OPCACHE="${OPCACHE}"

if [ -z "${XDEBUG}" ]; then
  XDEBUG="1"
fi

export FACTER_XDEBUG="${XDEBUG}"

if [ -z "${MEMCACHED}" ]; then
  MEMCACHED="1"
fi

export FACTER_MEMCACHED="${MEMCACHED}"

if [ -z "${REDIS}" ]; then
  REDIS="1"
fi

export FACTER_REDIS="${REDIS}"

if [ -z "${BLACKFIRE}" ]; then
  BLACKFIRE="1"
fi

export FACTER_BLACKFIRE="${BLACKFIRE}"

if [ -z "${APCU}" ]; then
  APCU="1"
fi

export FACTER_APCU="${APCU}"

if [ -z "${APD}" ]; then
  APD="1"
fi

export FACTER_APD="${APD}"

for VARIABLE in $(env); do
  if [[ "${VARIABLE}" =~ ^FREETDS_[[:digit:]]_HOST=.*$ ]]; then
    i="$(echo ${VARIABLE} | awk -F '_' '{ print $2 }')"

    FREETDS_HOST="FREETDS_${i}_HOST"
    FREETDS_PORT="FREETDS_${i}_PORT"
    FREETDS_TDS_VERSION="FREETDS_${i}_TDS_VERSION"
    FREETDS_SERVER_NAME="FREETDS_${i}_SERVER_NAME"

    if [ -z "${!FREETDS_HOST}" ]; then
      continue
    fi

    if [ -z "${!FREETDS_PORT}" ]; then
      declare "${FREETDS_PORT}=1433"
    fi

    if [ -z "${!FREETDS_TDS_VERSION}" ]; then
      declare "${FREETDS_TDS_VERSION}=8.0"
    fi

    if [ -z "${!FREETDS_SERVER_NAME}" ]; then
      declare "${FREETDS_SERVER_NAME}=server-${i}"
    fi

    export "FACTER_${FREETDS_HOST}=${!FREETDS_HOST}"
    export "FACTER_${FREETDS_PORT}=${!FREETDS_PORT}"
    export "FACTER_${FREETDS_TDS_VERSION}=${!FREETDS_TDS_VERSION}"
    export "FACTER_${FREETDS_SERVER_NAME}=${!FREETDS_SERVER_NAME}"
  fi
done
