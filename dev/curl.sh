#!/usr/bin/env bash

set -ex

direnv_allow() {
  find . -name ".envrc" | while read -r file; do
    # 获取文件的目录路径
    dir=$(dirname "$file")

    # 进入目录
    cd "$dir" || continue

    # 运行 direnv allow
    direnv allow

    # 返回到原始目录（这样你可以处理多个子目录，如果存在多个 .envrc 文件）
    cd - || continue
  done
}

set -x
mkdir -p ~/art
cd ~/art
git clone --depth=1 git@github.com:xxai-art/docker.git
git clone --depth=1 git@github.com:aier-dev/conf.git
git clone --depth=1 git@github.com:xxai-art/rsrv.git

cd docker/dev
direnv_allow
./up.sh

cd ~/art/rsrv
direnv_allow
./init.sh

mkdir -p ~/art/ops
cd ~/art/ops
git clone --depth=1 git@github.com:wactax/ops.soft.git soft
cd soft/backup
direnv_allow

./greptime/load.sh
./redis/load.sh
./pg/load.sh
./qdrant/load.sh
