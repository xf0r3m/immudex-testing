#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;

if [ $(dpkg --print-architecture) = "amd64" ]; then
  wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-116.0.3-1.en-US.linux-x86_64.tar.bz2;
  tar -xf librewolf-116.0.3-1.en-US.linux-x86_64.tar.bz2 -C /usr/lib;
  rm librewolf-116.0.3-1.en-US.linux-x86_64.tar.bz2;
else
  wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-116.0.3-1.en-US.linux-i686.tar.bz2;
  tar -xf librewolf-116.0.3-1.en-US.linux-i686.tar.bz2 -C /usr/lib;
  rm librewolf-116.0.3-1.en-US.linux-i686.tar.bz2;
fi
ln -s /usr/lib/librewolf/librewolf /usr/bin/librewolf;

cp -vv ~/immudex-testing/launchers/${VERSION}/16844254192.desktop /etc/skel/.config/xfce4/panel/launcher-5;
cp -vv ~/immudex-testing/files/${VERSION}/terminalrc /etc/skel/.config/xfce4/terminal;
cp -vv ~/immudex-testing/files/${VERSION}/librewolf.desktop /usr/share/applications;
cp -vv ~/immudex-testing/files/${VERSION}/gtk-main.css /usr/share/xfce4-notes-plugin/gtk-3.0;
cp -vv ~/immudex-testing/tools/${VERSION}/secured-firefox /usr/local/bin;

cp -vv ~/immudex-testing/images/${VERSION}/lightdm_wallpaper.jpg /usr/share/images/desktop-base;

tar -xf ~/immudex-testing/files/${VERSION}/librewolf.tgz -C /etc/skel;
recreate_users;

set_mime;

tidy;
