#!/bin/bash

echo "                                              
喵喵一键安卓脚本
源作者: hoping喵，坏水秋
本项目修改者: 灵嗷嗷
来自: 类脑/Claude3.5先行破限组/小水Claude甲字号群
类脑Discord: https://discord.gg/HWNkueX34q
"

echo -e "\033[0;31m开魔法！开魔法！开魔法！\033[0m\n"
echo -e "\033[0;31m不开！就不开！\033[0m\n"
echo "正在为Ubuntu更改镜像源"
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main@' $PREFIX/etc/apt/sources.list
apt update && apt upgrade

# read -p "确保开了魔法后按回车继续"

current=/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu

yes | apt update

yes | apt upgrade

# 安装proot-distro
DEBIAN_FRONTEND=noninteractive pkg install proot-distro -y

# 导入cache
mkdir -p /data/data/com.termux/files/usr/var/lib/proot-distro/dlcache
curl -o "/data/data/com.termux/files/usr/var/lib/proot-distro/dlcache/ubuntu-noble-aarch64-pd-v4.18.0.tar.xz" https://ghproxy.net/https://github.com/termux/proot-distro/releases/download/v4.18.0/ubuntu-noble-aarch64-pd-v4.18.0.tar.xz

# 创建并安装Ubuntu
DEBIAN_FRONTEND=noninteractive proot-distro install ubuntu

# Check Ubuntu installed successfully
 if [ ! -d "$current" ]; then
   echo "Ubuntu安装失败了，请更换魔法或者手动安装Ubuntu喵~"
    exit 1
 fi

    echo "Ubuntu成功安装到Termux"

echo "正在安装相应软件喵~"

DEBIAN_FRONTEND=noninteractive pkg install git vim curl tar xz-utils python3 zip -y

if [ -d "SillyTavern" ]; then
  cp -r SillyTavern $current/root/
fi

cd $current/root

echo "正在为Ubuntu更改镜像源"
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main@' $PREFIX/etc/apt/sources.list
apt update && apt upgrade

echo "正在为Ubuntu安装node喵~"
if [ ! -d node-v20.10.0-linux-arm64.tar.xz ]; then
    curl -O https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/v20.10.0/node-v20.10.0-linux-arm64.tar.xz

tar xf node-v20.10.0-linux-arm64.tar.xz

echo "export PATH=\$PATH:/root/node-v20.10.0-linux-arm64/bin" >>$current/etc/profile
fi

if [ ! -d "SillyTavern" ]; then
git clone https://ghproxy.net/https://github.com/SillyTavern/SillyTavern
fi

git clone -b test https://ghproxy.net/https://github.com/teralomaniac/clewd

echo -e "\033[0;33m本操作仅为破限下载提供方便，所有破限皆为收录，喵喵不具有破限所有权\033[0m"
read -p "回车进行导入喵~"
git clone https://ghproxy.net/https://github.com/hopingmiao/promot.git st_promot
if  [ ! -d "st_promot" ]; then
    echo -e "(*꒦ິ⌓꒦ີ)\n\033[0;33m hoping：因网络波动预设文件下载失败了，更换网络后再试喵~\n\033[0m"
else
    cp -r $current/root/st_promot/. $current/root/SillyTavern/public/'OpenAI Settings'/
    echo -e "\033[0;33m破限已成功导入，安装完毕后启动酒馆即可看到喵~\033[0m"
fi

curl -O https://ghproxy.net/https://raw.githubusercontent.com/LINKLang/termux_using_Claue/main/sac.sh

if [ ! -f "$current/root/sac.sh" ]; then
   echo "启动文件下载失败了，换个魔法或者手动下载试试吧"
   exit
fi

echo "bash /root/sac.sh" >>$current/root/.bashrc

echo "proot-distro login ubuntu" >>/data/data/com.termux/files/home/.bashrc

source /data/data/com.termux/files/home/.bashrc

exit
