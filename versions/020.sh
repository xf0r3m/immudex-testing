#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;
install_packages isolinux;

cp -vv ~/immudex-testing/tools/${VERSION}/immudex_install /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/immudex_crypt /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/immudex_upgrade /usr/local/bin;

cp -vv ~/immudex-testing/files/${VERSION}/terminalrc /etc/skel/.config/xfce4/terminal;

recreate_users;
set_notifier_packages;

tidy;
