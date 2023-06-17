#!/bin/bash

version=$(echo $0 | cut -d "." -f 1);
if [ ! "$version" ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi;

apt update
apt upgrade -y

if [ ! -d ~/immudex-testing ]; then
  cd;
  git clone https://github.com/xf0r3m/immudex-testing;
fi

cp -v ~/immudex-testing/tools/${version}/immudex_crypt /usr/local/bin;
cp -v ~/immudex-testing/tools/${version}/morketsmerke /usr/local/bin;
cp -v ~/immudex-testing/tools/${version}/ytplay /usr/local/bin;
cp -v ~/immudex-testing/tools/${version}/padlock /usr/local/bin;

chmod +x /usr/local/bin/*;

mv /usr/share/images/desktop-base/padlock.png /usr/share/icons;
mv /usr/share/images/desktop-base/unlocked.png /usr/share/icons;

if [ ! -d xfcedebian ]; then
  git clone -b testing https://github.com/xf0r3m/xfcedebian;
  chmod +x xfcedebian/install.sh;
  cd xfcedebian
  bash install.sh;
fi

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

echo "root:toor" | chpasswd;

usermod -aG libvirt,libvirt-qemu xf0r3m;
usermod -aG libvirt,libvirt-qemu user;

rm -rf ~/immudex-testing;
rm -rf ~/xfcedebian;
apt-get clean;
apt-get clean;
apt-get autoremove;
apt-get autoclean;
echo > ~/.bash_history;
history -c   
