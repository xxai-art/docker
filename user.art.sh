#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

USER_UID=3003
USER_NAME=art
groupadd -g $USER_UID $USER_NAME || groupmod -g $USER_UID $USER_NAME
useradd -u $USER_UID -g $USER_NAME $USER_NAME || usermod -u $USER_UID $USER_NAME
USER_HOME=/home/$USER_NAME
mkdir -p $USER_HOME

chown -R $USER_NAME:$USER_NAME $USER_HOME

# 检查/etc/sudoers文件中是否已经存在$USER_NAME用户的配置
grep -P "^\s*$USER_NAME\s+" /etc/sudoers && { echo "$USER_NAME用户已经在sudoers文件中，不进行任何操作"; } || {
  # 添加$USER_NAME用户的sudo权限配置，无需密码
  echo "$USER_NAME ALL=(ALL:ALL) NOPASSWD: ALL" >>/etc/sudoers
  echo "已为$USER_NAME用户添加sudo权限，并设置为无需密码"
}
