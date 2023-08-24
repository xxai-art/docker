#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

chown $USER ./data/mq
direnv exec . ../../docker/redis/acl.coffee $DIR
