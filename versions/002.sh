#!/bin/bash

version=$(echo $0 | cut -d "." -f 1);
if [ ! "$version" ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi;

apt update
apt upgrade -y

apt-get clean;
apt-get clean;
apt-get autoremove -y;
apt-get autoclean;
echo > ~/.bash_history;
history -c   
