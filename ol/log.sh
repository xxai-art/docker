#!/usr/bin/env bash
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
DIR=$(realpath $0) && DIR=${DIR%/*}
set -ex
cd $DIR/$(hostname)
sudo direnv allow

direnv exec . docker-compose logs -f $1
