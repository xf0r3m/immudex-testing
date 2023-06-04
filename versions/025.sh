#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;

cp -vv ~/immudex-testing/tools/${VERSION}/immudex_crypt /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/immudex_hostname /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/meteo /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/ytplay /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/pl /usr/local/bin;

cp -vv ~/immudex-testing/files/${VERSION}/immudex_hostname.service /etc/systemd/system;
systemctl enable immudex_hostname.service;

echo "root:toor" | chpasswd;
tidy;
