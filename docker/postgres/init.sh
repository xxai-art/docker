#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

ensure() {
  if [ ! -d "$1" ]; then
    git clone --depth=1 git@github.com:xxai-art/$1.git || git clone --depth=1 https://github.com/xxai-art/$1.git
  fi
}
cd plugin
ensure md5hash
ensure moreint
