#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

direnv exec . ../docker/redis/acl.coffee $DIR
direnv exec . docker-compose up -d
