#!/bin/bash

Green="\033[32m" 
Red="\033[31m" 
Blue="\033[33m"
Font="\033[0m"

Info="${Green}[Info]${Font}"
OK="${Green}[OK]${Font}"
Error="${Red}[Error]${Font}"

if [ -z $1 ];then
	echo "请输入aria2 RPC密码"
	exit 1
fi
pass=$1

basic_dependency(){
    sudo apt update
    sudo apt install wget unzip net-tools bc curl sudo -y     
}

port_exist_check(){
    if [[ 0 -eq `netstat -tlpn | grep "$1"| wc -l` ]];then
        echo -e "${OK} ${Blue} $1 端口未被占用 ${Font}"
        sleep 1
    else
        echo -e "${Error} ${Red} $1 端口被占用，请检查占用进程 结束后重新运行脚本 ${Font}"
        netstat -tlpn | grep "$1"
        exit 1
    fi
}

aria_install(){
echo -e "${Green} 开始安装Aria2 ${Font}"F
sudo apt-get install aria2 cron -y
cd ~
mkdir Download
mkdir "${HOME}/.aria2" && cd "${HOME}/.aria2"
echo '' > ${HOME}/.aria2/aria2.session
chmod 777 ${HOME}/.aria2/aria2.session
echo "dir=${HOME}/Download
rpc-secret=

disk-cache=32M
file-allocation=trunc
continue=true
check-certificate=false

max-concurrent-downloads=10
max-connection-per-server=16
min-split-size=1M
split=16
max-overall-upload-limit=10K
disable-ipv6=false
input-file=${HOME}/.aria2/aria2.session
save-session=${HOME}/.aria2/aria2.session

enable-rpc=true
rpc-allow-origin-all=true
rpc-listen-all=true
rpc-listen-port=6800

follow-torrent=true
listen-port=51413
enable-dht=true
enable-dht6=false
dht-listen-port=6881-6999
bt-enable-lpd=true
enable-peer-exchange=true
peer-id-prefix=-TR2770-
user-agent=netdisk;7.0.3.2;PC;PC-Windows;10.0.17763
seed-time=0
bt-seed-unverified=true
allow-overwrite=true
on-download-complete=${HOME}/aria2complete.sh
" > ${HOME}/.aria2/aria2.conf
sed -i "s/rpc-secret=/rpc-secret=${pass}/g" ${HOME}/.aria2/aria2.conf
}

init_install(){
    bash ${HOME}/aria2.sh stop
    bash ${HOME}/aria2.sh start
}

main(){
    basic_dependency
    aria_install
    init_install
}

main
