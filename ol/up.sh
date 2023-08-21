#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

cd $(hostname)
direnv allow
name=xxai.art

mkdir_ln() {
  if [ ! -e "$1" ]; then
    fp=/$2/$1/$name
    mkdir -p $fp
    ln -s $fp $1
  fi

}

mkdir_ln log var
mkdir_ln cache mnt
mkdir_ln data mnt

direnv exec . docker-compose up -d
