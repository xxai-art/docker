#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
source ../../docker/juicefs/bench.sh
juicefs objbench \
  --storage s3 \
  --access-key $AK \
  --secret-key $SK \
  $URL
