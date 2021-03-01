#!/usr/bin/env bash

set -o errexit -o nounset

cd /var/www/html

mkdir --parents upload/surveys
chown www-data:www-data --recursive \
  application/config tmp upload

exec "$@"
