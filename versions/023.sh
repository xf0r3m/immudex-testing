#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;

cp -vv ~/immudex-testing/tools/${VERSION}/immudex_branch /usr/local/bin;
chmod +x /usr/local/bin/immudex_branch;

cp -vv ~/immudex-testing/files/${VERSION}/.conkyrc /etc/skel; 

recreate_users;
set_notifier_packages;

rm /usr/share/images/desktop-base/no_trespass_abandon.jpeg;
rm /var/cache/apt/*.bin;
apt remove chirp -y;

tidy;
