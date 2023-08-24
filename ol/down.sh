#!/usr/bin/env bash

set -ex
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR/$(hostname)
direnv allow
direnv exec . docker-compose down
