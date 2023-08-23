#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

mkdir -p gdb
direnv exec . ../../docker/redis/acl.coffee $DIR
