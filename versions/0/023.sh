#!/bin/bash

set -e

VERSION=$(echo $0 | cut -d "." -f 1);

if [ ! "$1" ]; then exit 1; fi
if [ ! -d ~/immudex-testing ]; then exit 1; fi
if [ ! /sbin/debootstrap ]; then exit 1; fi

if [ "$1" = "--amd64" ] || [ "$1" = "--i386" ]; then
  if [ "$1" = "--amd64" ]; then arch="64"; else arch="32"; fi
  sudo rm -rf ~/immudex-testing/${arch}/chroot;
  sudo /sbin/debootstrap --arch=$(echo $1 | sed 's/-//g') bookworm ~/immudex-testing/${arch}/chroot http://deb.debian.org/debian
  sudo cat > 023_chroot.sh <<EOF
dhclient;
cd;
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing;
else apt install git -y && git clone https://github.com/xf0r3m/immudex-testing;

fi
source ~/immudex-testing/versions/template.sh;

echo "deb http://deb.debian.org/debian/ bookworm main" > /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ bookworm main" >> /etc/apt/sources.list;
echo "deb http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list;
echo "deb-src http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list;
echo "deb http://deb.debian.org/debian/ bookworm-updates main" >> /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ bookworm-updates main" >> /etc/apt/sources.list;
update_packages;


if [ "$arch" = "64" ]; then
install_packages --no-install-recommends linux-image-amd64 live-boot systemd-sysv -y;
else
install_packages --no-install-recommends linux-image-686-pae live-boot systemd-sysv -y;
fi

install_packages tzdata locales keyboard-configuration console-setup;

dpkg-reconfigure tzdata;
dpkg-reconfigure locales;
dpkg-reconfigure keyboard-configuration;
dpkg-reconfigure console-setup;

install_packages task-desktop task-xfce-desktop;

install_packages firejail ufw cryptsetup lsof extlinux grub-efi-amd64 efibootmgr bash-completion etherwake wakeonlan cifs-utils wget figlet mpv youtube-dl vim-gtk3 redshift irssi nmap nfs-common remmina python3-pip ffmpeg debootstrap squashfs-tools xorriso syslinux-efi grub-pc-bin grub-efi-amd64-bin mtools dosfstools chrony python3-venv isolinux rsync thunderbird gimp openvpn netselect-apt;

cd;

git clone https://github.com/xf0r3m/xfcedebian -b testing;
cd xfcedebian;
bash install.sh;

cd;

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
cp -vv ~/immudex-testing/files/${VERSION}/Klient\ poczty\ Thunderbird.desktop /etc/skel/Pulpit;
cp -vv ~/immudex-testing/files/${VERSION}/terminalrc /etc/skel/.config/xfce4/terminal;
cp -vv ~/immudex-testing/files/${VERSION}/mimeapps.list /etc/skel/.config;
cp -rvv ~/immudex-testing/files/${VERSION}/meteo /usr/share;
cp -rvv ~/immudex-testing/files/${VERSION}/sync.sh /usr/share;
cp -vv ~/immudex-testing/files/${VERSION}/conkyrc /etc/skel/.conkyrc;

tar -xzvf ~/immudex-testing/files/${VERSION}/mozilla.tgz -C /etc/skel;
cp -vv ~/immudex-testing/images/${VERSION}/* /usr/share/icons;

rm /usr/share/images/desktop-base/no_trespass_abandon.jpeg;

cat >> /etc/bash.bashrc << EOL
if [ ! -f /tmp/.motd ]; then
/usr/local/bin/motd2
touch /tmp/.motd;
fi
EOL

echo "alias chhome='export HOME=\\\$(pwd)'" >> /etc/bash.bashrc;
echo "alias ytstream='mpv --ytdl-format=best[heigth=480]'" >> /etc/bash.bashrc;

chmod u+s /usr/bin/ping;

/usr/sbin/ufw default deny incoming;
/usr/sbin/ufw default allow outgoing;
/usr/sbin/ufw enable;

echo "immudex" > /etc/hostname;
echo "127.0.1.1   immudex" >> /etc/hosts;

recreate_users;
echo "user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "xf0r3m ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
set_notifier_packages;

tidy;
EOF
  sudo cp 023_chroot.sh ~/immudex-testing/${arch}/chroot;
  sudo chroot ~/immudex-testing/${arch}/chroot bash 023_chroot.sh;
  sudo rm ~/immudex-testing/${arch}/chroot/023_chroot.sh;
else
  exit 1;
fi 
