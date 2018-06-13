#!/usr/bin/env bash

PHAPP_VERSION=0.6.2

set -e
set -x
cd `dirname $0`/..

if ! command -v phapp > /dev/null; then
  echo Installing phapp...
  curl -L https://github.com/drunomics/phapp-cli/releases/download/$PHAPP_VERSION/phapp.phar > phapp
  chmod +x phapp
  sudo mv phapp /usr/local/bin/phapp
else
  echo Phapp version `phapp --version` found.
fi

INSTALL_PROFILE_DIR=`basename $PWD`

echo "Adding distribution..."
composer config repositories.self path .

echo "Adding custom environment variables..."

cat - >> .defaults.env <<END
  INSTALL_PROFILE=thunder
  DEFAULT_LANGUAGE=en
  COMPOSE_PROJECT_NAME=swiper-gallery-demo
  ENV_UNIX_GROUP_WEBSERVER=www-data
END

echo "Setting up project..."
phapp setup travis
