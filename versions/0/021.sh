#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;

cp -vv ~/immudex-testing/tools/${VERSION}/immudex_install /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/create_media /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/immudex_upgrade /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/meteo /usr/local/bin;

cp -vv ~/immudex-testing/files/${VERSION}/mimeapps.list /etc/skel/.config;
cp -rvv ~/immudex-testing/files/${VERSION}/meteo /usr/share;

recreate_users;
set_notifier_packages;

tidy;
