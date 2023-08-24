#!/usr/bin/env bash
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

direnv exec . docker-compose ps
