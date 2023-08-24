#!/usr/bin/env bash
src=$HOME
bak=/mnt/btfs.snapshot$src
if [ ! -d "$bak" ]; then
  mkdir -p $bak
  btrfs subvolume create $HOME
fi
fp=$bak/$(date "+%Y-%m-%d_%H.%M.%S")
btrfs subvolume snapshot -r $src $fp
