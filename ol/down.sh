#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

cd $(hostname)
direnv allow
direnv exec . docker-compose down
