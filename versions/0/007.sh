#!/bin/bash

function update_packages() {
  dhclient; 
  apt update;
  apt upgrade -y;
}

function install_packages() {
  apt install $@ -y;
}

function get_immudex_testing_project() {
  if [ ! -d ~/immudex-testing ]; then
    cd;
    git clone https://github.com/xf0r3m/immudex-testing.git;
  fi
}

function recreate_users() {
  userdel -r user;
  userdel -r xf0r3m;

  useradd -m -s /bin/bash user;
  if [ ! -f /home/user/.vimrc ]; then
    cp -rvv /etc/skel/.??* /home/user;
    chown -R user:user /home/user;
  fi
  echo "user:user1" | chpasswd;

  useradd -m -s /bin/bash xf0r3m;
  if [ ! -f /home/xf0r3m/.vimrc ]; then
    cp -rvv /etc/skel/.??* /home/xf0r3m;
    chown -R xf0r3m:xf0r3m /home/xf0r3m;
  fi
  echo "xf0r3m:xf0r3m1" | chpasswd;

  usermod -aG libvirt,libvirt-qemu xf0r3m;
  usermod -aG libvirt,libvirt-qemu user;
}

function tidy() {
  apt-get clean;
  apt-get clean;
  apt-get autoremove -y;
  apt-get autoclean;
  rm -rf ~/immudex-testing;
  echo > ~/.bash_history;
  history -c   
}

VERSION=$(echo $0 | cut -d "." -f 1);
if [ ! "$VERSION" ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi;

update_packages;
install_packages gstreamer1.0-libav gstreamer1.0-plugins-good python3-pip ffmpeg libadwaita-1-0 gir1.2-adw-1;
install_packages --no-install-recommends libgtk-4-bin libgtk-4-common libgtk-4-dev;

rm /usr/bin/python3;
ln -s /usr/bin/python3.10 /usr/bin/python3;

install_packages python3.10-dev;

cd;
git clone https://gitlab.com/zehkira/myuzi.git;
cd myuzi/source;
pip install nuitka
pip install ytmusicapi
make install;
cd;
rm -rf myuzi;

get_immudex_testing_project;

rm -rf /etc/skel/.mozilla;
tar -xzvf ~/immudex-testing/files/${VERSION}/mozilla.tgz -C /etc/skel;
cp -vv ~/immudex-testing/files/${VERSION}/16608166085.desktop /etc/skel/.config/xfce4/panel/launcher-19/16608166085.desktop;

recreate_users;

cp -vv ~/immudex-testing/files/005/irssi.desktop /home/xf0r3m/.config/autostart;
chown -R 1001:1001 /home/xf0r3m;

tidy;
