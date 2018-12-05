#!/bin/bash

# Launches backstop via the docker image as configured below.
# Any additional arguments are passed on to the backstop command, e.g. "test".
#
# The following environment variables must be set:
# BASE_URL: The URL via which the website can be accessed.
#
# The following environment variables can be set:
# DOCKER_RUN_EXTRA_ARGS: Some additional arguments po pass to "docker run".

DOCKER_IMAGE=backstopjs/backstopjs
DOCKER_IMAGE_TAG=v3.1.19
# Default to empty extra args if the variable is not provided.
DOCKER_RUN_EXTRA_ARGS=${DOCKER_RUN_EXTRA_ARGS:-''}

cd `dirname $0`
VCS_DIR=../..

# If no base URL is given run with local setup.
if [[ ! $BASE_URL ]]; then
  LOCAL_RUN=1
  source ../../dotenv/loader.sh
  export BASE_URL=${PHAPP_BASE_URL}
fi

# Support adding http auth.
if [[ $HTTP_AUTH_USER ]]; then
  BASE_URL=${BASE_URL/:\/\//:\/\/$HTTP_AUTH_USER:$HTTP_AUTH_PASSWORD@}
fi

echo "Executing backstopjs for URL $BASE_URL..."

# Adjust backstop config.
cp backstop.config.json backstop.config-prepared.json
cd prepare-config
COMPOSE_FILE=

docker-compose up

cd ..
if [[ $1 == 'openreport' ]]; then
  # Work around the docker image not supporting openreport yet.
  xdg-open ./backstop_data/html_report/index.html
  exit $?
fi

# Set shared memory size to 512m as described in
# https://github.com/garris/BackstopJS/issues/537 and run it.

# Note that we run docker as current user so files are created with permissions
# suiting for the current user.
docker run --shm-size 512m -u `id -u $USER` --rm -v $(pwd):/src --network=${DOCKER_NETWORK-host} $DOCKER_RUN_EXTRA_ARGS \
  $DOCKER_IMAGE:$DOCKER_IMAGE_TAG --config=backstop.config-prepared.json $@

EXIT_CODE=$?

if [[ $LOCAL_RUN ]]; then
  # Make the report available via the regular webserver.
  ln -nsf ../tests/backstop/backstop_data $VCS_DIR/web/backstopjs
  echo Report: $BASE_URL/backstopjs
fi

if [[ $1 = 'test' ]]; then
  [[ $EXIT_CODE -eq 0 ]] && echo BACKSTOPJS PASSED. || echo BACKSTOPJS FAILED.
fi
exit $EXIT_CODE
