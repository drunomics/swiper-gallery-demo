#!/usr/bin/env bash

set -e
set -x
cd `dirname $0`/..

# Run a web service via docker composer

[ -d devsetup-docker ] || \
  git clone https://github.com/drunomics/devsetup-docker.git --branch=1.x

echo "Adding compose environment variables..."

cat - > .docker.defaults.env <<END
  # Be sure to sure the directory including the vcs checkout is shared as
  # docker volumes. This allows composer to link the install profile to the
  # root directory and the link will work in the container.
  # COMPOSE_CODE_DIR=../..
  WEB_DIRECTORY=web
  WEB_WORKING_DIR=/srv/default/vcs
END

echo "Running server..."
source dotenv/loader.sh
docker-compose up -d
