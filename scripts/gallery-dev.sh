#!/usr/bin/env bash
# Checks out the swiper gallery repo for local development.
# Running composer install will reset this again.
cd `dirname $0`/../web/modules/drunomics/swiper_gallery

git remote show composer 2> /dev/null && git remote remove composer

git checkout develop
git branch --set-upstream-to=origin/develop develop
git pull

cd build
npm install
