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

cp /usr/bin/youtube-dl /usr/bin/youtube-dl-orig;
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/bin/youtube-dl;
chmod +x /usr/bin/youtube-dl;

install_packages grub-efi-ia32-bin;

get_immudex_testing_project;

cp -rvv ~/immudex-testing/files/${VERSION}/libreoffice /etc/skel/.config;
cp -rvv ~/immudex-testing/files/${VERSION}/.irssi /etc/skel;

recreate_users;

cp -vv ~/immudex-testing/files/${VERSION}/irssi.desktop /home/xf0r3m/.config/autostart;
chown -R 1001:1001 /home/xf0r3m;

cp -vv ~/immudex-testing/images/${VERSION}/* /usr/share/images/desktop-base;
sed -i 's/mark-korneev-pixelart-snow.jpg/no_trespass_abandon.jpeg/' /etc/lightdm/lightdm-gtk-greeter.conf;
sed -i 's/avatar.jpg/immudex_xfce_greeter_logo.png/' /etc/lightdm/lightdm-gtk-greeter.conf;

tidy;
