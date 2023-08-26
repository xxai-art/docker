#!/usr/bin/env bash

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
DIR=$(realpath $0) && DIR=${DIR%/*}
set -ex
cd $DIR/$(hostname)
direnv allow
if [ -z "$1" ]; then
  direnv exec . docker-compose down
else
  direnv exec . docker-compose stop $1
  direnv exec . docker-compose rm $1
fi
