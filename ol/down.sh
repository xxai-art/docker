#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

cd $(hostname)
sudo direnv allow
sudo direnv exec . docker-compose down
