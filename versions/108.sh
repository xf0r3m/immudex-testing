#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;

cp -vv ~/immudex-testing/tools/${VERSION}/idle-clic /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/pl /usr/local/bin;

cp -vv ~/immudex-testing/files/${VERSION}/xfwm4.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml;

recreate_users;

set_mime;

tidy;
