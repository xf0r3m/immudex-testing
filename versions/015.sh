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

function set_default_wallpaper() {
  rm /usr/share/images/desktop-base/default;
  ln -s /usr/share/images/desktop-base/$1 /usr/share/images/desktop-base/default;
}

VERSION=$(echo $0 | cut -d "." -f 1);
if [ ! "$VERSION" ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi;

echo "deb http://deb.debian.org/debian bookworm main" > /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian bookworm main" >> /etc/apt/sources.list;
echo "deb http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list;
echo "deb-src http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list;
echo "deb http://deb.debian.org/debian bookworm-updates main" >> /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian bookworm-updates main" >> /etc/apt/sources.list;

update_packages;
install_packages openvpn netselect-apt;

set_default_wallpaper altai_1920x1080.png;

tidy;