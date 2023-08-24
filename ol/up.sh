#!/usr/bin/env bash
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
DIR=$(realpath $0) && DIR=${DIR%/*}
set -ex
cd $DIR/$(hostname)
sudo direnv allow
name=xxai.art

mkdir_ln() {
  if [ ! -e "$1" ]; then
    rm -rf $1
    fp=/$2/$1/$name
    mkdir -p $fp
    ln -s $fp $1
  fi

}

mkdir_ln log var
mkdir_ln cache mnt
mkdir_ln data mnt

direnv exec . docker-compose up -d
