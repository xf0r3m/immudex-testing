#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;
install_packages gvfs-backends;

head -1 /etc/apt/sources.list | tee /etc/apt/sources.list.d/xfce4-notes-plugin.list;
sed -i 's/bookworm/experimental/' /etc/apt/sources.list.d/xfce4-notes-plugin.list;
apt update;
apt install xfce4-notes-plugin -y;
rm /etc/apt/sources.list.d/xfce4-notes-plugin.list;
apt update;

cp ~/immudex-testing/files/${VERSION}/gtk-main.css /usr/share/xfce4-notes-plugin/gtk-3.0/;
cp ~/immudex-testing/images/${VERSION}/notes-background.jpg /usr/share/images/desktop-base;
cp ~/immudex-testing/tools/${VERSION}/autostart-x4notes /usr/local/bin;
chmod +x /usr/local/bin/autostart-x4notes;

set_xfce4_notes_autostart;

tidy;
