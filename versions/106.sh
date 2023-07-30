#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;

cp -vv ~/immudex-testing/tools/${VERSION}/create_media /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/immudex_hostname /usr/local/bin;

rm -rf /etc/skel/.mozilla;
tar -xzvf ~/immudex-testing/files/${VERSION}/mozilla.tgz -C /etc/skel;
recreate_users;

set_mime;

tidy;
