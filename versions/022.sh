#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;
install_packages rsync;

cp -vv ~/immudex-testing/tools/${VERSION}/immudex_install /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/sync.sh /usr/local/bin;
chmod +x /usr/local/bin/*

cp -rvv ~/immudex-testing/files/${VERSION}/sync.sh /usr/share; 

set_default_wallpaper altai_1920x1080.png;

tidy;
