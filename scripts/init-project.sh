#!/usr/bin/env bash
cd `dirname $0`/..
set -e
set -x

source dotenv/loader.sh

# Run build on the host so we can leverage build caches.
phapp build
# Then install in the container.
./dcp.sh up -d
./dcp.sh exec web phapp init --no-build
