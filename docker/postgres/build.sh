#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

./init.sh

img=xxai/postgres
tag=$(date +%Y-%m-%d)

docker buildx build -t $img:$tag -t $img:latest .
