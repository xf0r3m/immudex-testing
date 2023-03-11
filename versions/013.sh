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

set -e

if [ ! "$1" ]; then exit 1; fi
if [ ! -d ~/immudex-testing ]; then exit 1; fi
if [ ! /sbin/debootstrap ]; then exit 1; fi

if [ "$1" = "--amd64" ] || [ "$1" = "--i386" ]; then
  if [ "$1" = "--amd64" ]; then arch="64"; else arch="32"; fi
  sudo rm -rf ~/immudex-testing/${arch}/chroot;
  sudo /sbin/debootstrap --arch=$(echo $1 | sed 's/-//g') bookworm ~/immudex-testing/${arch}/chroot http://ftp.icm.edu.pl/debian
  sudo cat > 013_chroot.sh <<EOF
dhclient;
if [ "$arch" = "64" ]; then
apt install --no-install-recommends linux-image-amd64 live-boot systemd-sysv -y;
else
apt install --no-install-recommends linux-image-686-pae live-boot systemd-sysv -y;
fi
apt install -y tzdata locales keyboard-configuration console-setup
dpkg-reconfigure tzdata;
dpkg-reconfigure locales;
dpkg-reconfigure keyboard-configuration;
dpkg-reconfigure console-setup;
apt install -y task-desktop task-xfce-desktop;
apt install -y git firejail ufw cryptsetup lsof extlinux grub-efi-amd64 efibootmgr bash-completion etherwake wakeonlan cifs-utils wget figlet chirp mpv youtube-dl vim-gtk3 redshift irssi nmap nfs-common remmina python3-pip ffmpeg debootstrap squashfs-tools xorriso syslinux-efi grub-pc-bin grub-efi-amd64-bin mtools dosfstools chrony python3-venv;
cd;
if [ ! -x /usr/bin/git ]; then apt install git -y; fi
git clone https://github.com/xf0r3m/xfcedebian -b testing;
cd xfcedebian;
bash install.sh;
cd;
git clone https://github.com/xf0r3m/immudex-testing;
cp -vv ~/immudex-testing/tools/${VERSION}/* /usr/local/bin;
chmod +x /usr/local/bin/*;
mkdir /etc/skel/.irssi
cp -vv ~/immudex-testing/files/${VERSION}/config /etc/skel/.irssi;
cp -vv ~/immudex-testing/files/${VERSION}/default.theme /etc/skel/.irssi;
cp -rvv ~/immudex-testing/files/${VERSION}/libreoffice /etc/skel/.config;
cp -vv ~/immudex-testing/files/${VERSION}/firejail.config /etc/firejail;
cp -vv ~/immudex-testing/files/${VERSION}/Notifier\ -\ distro.desktop /etc/skel/.config/autostart;
cp -vv ~/immudex-testing/files/${VERSION}/redshift.conf /etc/skel/.config;
cp -vv ~/immudex-testing/files/${VERSION}/redshift.desktop /etc/skel/.config/autostart;
tar -xzvf ~/immudex-testing/files/${VERSION}/mozilla.tgz -C /etc/skel;
cp -vv ~/immudex-testing/images/${VERSION}/* /usr/share/icons;
cat >> /etc/bash.bashrc << EOL
if [ ! -f /tmp/.motd ]; then
/usr/local/bin/motd2
touch /tmp/.motd;
fi
EOL
echo "alias chhome='export HOME=\\\$(pwd)'" >> /etc/bash.bashrc;
echo "alias ytstream='mpv --ytdl-format=best[heigth=480]'" >> /etc/bash.bashrc;
chmod u+s /usr/bin/ping;
sed -i -e 's/chirpw/sudo chirpw/' -e 's/false/true/' /usr/share/applications/chirp.desktop;
/usr/sbin/ufw default deny incoming;
/usr/sbin/ufw default allow outgoing;
/usr/sbin/ufw enable;
echo "immudex" >> /etc/hostname;
echo "127.0.1.1   immudex" >> /etc/hosts;
echo "deb http://ftp.icm.edu.pl/pub/Linux/debian/ bookworm main" > /etc/apt/source.list;
echo "deb-src http://ftp.icm.edu.pl/pub/Linux/debian/ bookworm main" >> /etc/apt/source.list;
echo "deb http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/source.list;
echo "deb-src http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/source.list;
echo "deb http://ftp.icm.edu.pl/pub/Linux/debian/ bookworm-updates main" >> /etc/apt/source.list;
echo "deb-src http://ftp.icm.edu.pl/pub/Linux/debian/ bookworm-updates main" >> /etc/apt/source.list;
apt update;
apt upgrade -y;
useradd -m -s /bin/bash user;
if [ ! -f /home/user/.vimrc ]; then
cp -rvv /etc/skel/?* /home/user;
cp -rvv /etc/skel/.??* /home/user;
chown -R user:user /home/user;
fi
echo "user:user1" | chpasswd;
useradd -m -s /bin/bash xf0r3m;
if [ ! -f /home/xf0r3m/.vimrc ]; then
cp -rvv /etc/skel/?* /home/xf0r3m;
cp -rvv /etc/skel/.??* /home/xf0r3m;
chown -R xf0r3m:xf0r3m /home/xf0r3m;
fi
echo "xf0r3m:xf0r3m1" | chpasswd;
usermod -aG libvirt,libvirt-qemu xf0r3m;
usermod -aG libvirt,libvirt-qemu user;
echo "xf0r3m ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root:toor" | chpasswd;
mkdir /home/user/.local
tar -xvf ~/immudex-testing/files/${VERSION}/local_user.tar -C /home/user/.local;
chown -R user:user /home/user/.local;
mkdir /home/xf0r3m/.local;
tar -xvf ~/immudex-testing/files/${VERSION}/local_xf0r3m.tar -C /home/xf0r3m/.local;
chown -R xf0r3m:xf0r3m /home/xf0r3m/.local;
cp -vv ~/immudex-testing/files/${VERSION}/Notifier\ -\ packages.desktop /home/xf0r3m/.config/autostart
chown xf0r3m:xf0r3m /home/xf0r3m/.config/autostart/Notifier\ -\ packages.desktop

rm -rf ~/immudex-testing;
rm -rf ~/xfcedebian;
apt-get clean;
apt-get clean;
apt-get autoclean;
apt-get autoremove -y;
echo > ~/.bash_history;
history -c
EOF
  sudo cp 013_chroot.sh ~/immudex-testing/${arch}/chroot;
  sudo chroot ~/immudex-testing/${arch}/chroot bash 013_chroot.sh;
  sudo rm ~/immudex-testing/${arch}/chroot/013_chroot.sh;
else
  exit 1;
fi 
