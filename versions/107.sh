#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;
apt purge -y xpra;

cp -vv ~/immudex-testing/files/${VERSION}/gtk-main.css /usr/share/xfce4-notes-plugin/gtk-3.0;
cp -vv ~/immudex-testing/files/${VERSION}/xfce4-keyboard-shortcuts.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml;

recreate_users;

set_mime;

tidy;
