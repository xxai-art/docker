#!/usr/bin/env bash

mkdir -p ~/art
cd ~/art
git clone --depth=1 git@github.com:xxai-art/docker.git
git clone --depth=1 git@github.com:aier-dev/conf.git
cd docker/dev
./up.sh
