#!/usr/bin/env bash
# Checks out the swiper gallery repo for local development.
# Running composer install will reset this again.
cd `dirname $0`/../web/modules/drunomics/swiper_gallery

git remote show composer 2> /dev/null && git remote remove composer

git fetch
git checkout 8.x-1.x
git branch --set-upstream-to=origin/8.x-1.x 8.x-1.x
git pull

cd build
npm install

echo $(pwd)
