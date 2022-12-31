#!/bin/bash

version=$(echo $0 | cut -d "." -f 1);
if [ ! "$version" ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi;

apt update
apt upgrade -y

if [ ! -d ~/immudex-testing ]; then
  cd;
  git clone https://github.com/xf0r3m/immudex-testing;
fi

cp -vv ~/immudex-testing/tools/${version}/* /usr/local/bin;
chmod +x /usr/local/bin/*;

cp -vv ~/immudex-testing/files/xfce4-panel.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml;

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

apt-get clean;
apt-get clean;
apt-get autoremove -y;
apt-get autoclean;
rm -rf ~/immudex-testing;
echo > ~/.bash_history;
history -c   
