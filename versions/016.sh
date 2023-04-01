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
    cp -rvv /etc/skel/?* /home/user;
    mkdir /home/user/.local;
    tar -xvf ~/immudex-testing/files/013/local_user.tar -C /home/user/.local;
    rm /home/user/.face;
    cp /usr/share/images/desktop-base/immudex_xfce_greeter_logo.png /home/user/.face;
    chown -R user:user /home/user;
  fi
  echo "user:user1" | chpasswd;

  useradd -m -s /bin/bash xf0r3m;
  if [ ! -f /home/xf0r3m/.vimrc ]; then
    cp -rvv /etc/skel/.??* /home/xf0r3m;
    cp -rvv /etc/skel/?* /home/xf0r3m;
    mkdir /home/xf0r3m/.local;
    tar -xvf ~/immudex-testing/files/013/local_xf0r3m.tar -C /home/xf0r3m/.local;
    rm /home/xf0r3m/.face;
    cp /usr/share/images/desktop-base/immudex_xfce_greeter_logo.png /home/xf0r3m/.face;
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

update_packages;

get_immudex_testing_project;

cp -vv ~/immudex-testing/files/${VERSION}/terminalrc /etc/skel/.config/xfce4/terminal;
cp -vv ~/immudex-testing/tools/${VERSION}/library.sh /usr/local/bin;
chmod +x /usr/local/bin/*;

recreate_users;

cp -vv ~/immudex-testing/files/011/Notifier\ -\ packages.desktop /home/xf0r3m/.config/autostart;
chown xf0r3m:xf0r3m /home/xf0r3m/.config/autostart/Notifier\ -\ packages.desktop;

tidy;
