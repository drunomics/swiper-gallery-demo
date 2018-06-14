#!/usr/bin/env bash
# Exports initial db-dump & files from current site. The initial database & files
# can be imported again via `phapp init`.

# run script from within the container, eg:
# `./dcp.sh exec web ./scripts/export-init.sh`

drush sql-dump --result-file=../dumps/init.sql --gzip --skip-tables-key=common
tar -zcvf ./dumps/files.tar.gz web/sites/default/files/2018-06/
