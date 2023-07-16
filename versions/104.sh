#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;

cp -vv ~/immudex-testing/files/${VERSION}/xfce4-keyboard-shortcuts.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml;
cp -vv ~/immudex-testing/files/${VERSION}/whiskermenu-1.rc /etc/skel/.config/xfce4/panel; 

recreate_users;

set_default_wallpaper d13_wallpaper.png;

set_mime;

tidy;
