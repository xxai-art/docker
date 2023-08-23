#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

if ! [ -x "$(command -v juicefs)" ]; then
  curl -sSL https://d.juicefs.com/install | sh -
fi

REDIS=redis://$JK_USER:$JK_PASSWORD@$JK_HOST_PORT/0

juicefs format \
  --storage s3 \
  --bucket $JUICEFS_S3_BUCKET \
  --access-key $JUICEFS_S3_AK \
  --secret-key $JUICEFS_S3_SK \
  --compress=zstd \
  --trash-days=1 \
  $REDIS \
  art-fs

MOUNT=/jfs
mkdir -p $MOUNT
CACHE=/mnt/cache$MOUNT
mkdir -p $CACHE

juicefs mount \
  --background \
  -o writeback_cache,allow_other \
  --update-fstab --writeback \
  --cache-dir $CACHE \
  --cache-size 60240 \
  --max-uploads=512 \
  $REDIS \
  $MOUNT
