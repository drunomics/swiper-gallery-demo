#!/usr/bin/env bash

for i in "$@"
do
  case $i in
      --headless)
      HEADLESS=1
      shift
      ;;
      --xdebug)
      export XDEBUG_CONFIG="remote_enable=1 remote_mode=req remote_port=9000 remote_host=127.0.0.1 remote_connect_back=0"
      shift
      ;;
      *)
      # unknown option
      ;;
  esac
done

ARGS=""

if [[ $HEADLESS = "1" ]]; then
  ARGS="--disable-gpu --headless"
fi

(google-chrome-stable $ARGS --user-data-dir=${HOME}/.google-chrome/behat --remote-debugging-address=127.0.0.1 --remote-debugging-port=9222 )&

cd `dirname $0`/..
./tests/behat/run.sh $@
behat_exit=$?

# End with stopping all sub-process; i.e. chrome.
[[ -z "$(jobs -p)" ]] || kill $(jobs -p)

if [ "$behat_exit" -eq 0 ]
then
  exit 0
else
  exit 1
fi
