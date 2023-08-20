#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

docker ps -q | xargs docker inspect --format='{{.Name}}' | sed 's/^\///'
