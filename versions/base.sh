#!/bin/bash

set -e

ARCH=$(dpkg --print-architecture);
LWVER='121.0-1';
LWTEST=1;

if [ $ARCH = "amd64" ]; then
  KARCH="amd64";
else
  KARCH="686-pae";
fi

if [ $LWTEST -eq 0 ]; then
  LWPATH="https://ftp.morketsmerke.org/immudex/testing/software/librewolf/testing";
else
  LWPATH="https://ftp.morketsmerke.org/immudex/testing/software/librewolf";
fi

if [ $ARCH = "amd64" ]; then
  LWARCH="x86_64";
else
  LWARCH="i686";
fi

cd;
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing;
else apt install git -y && git clone https://github.com/xf0r3m/immudex-testing;

fi
source ~/immudex-testing/versions/template.sh;

echo "deb http://deb.debian.org/debian/ testing main" > /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ testing main" >> /etc/apt/sources.list;
echo "deb http://security.debian.org/debian-security testing-security main" >> /etc/apt/sources.list;
echo "deb-src http://security.debian.org/debian-security testing-security main" >> /etc/apt/sources.list;
echo "deb http://deb.debian.org/debian/ testing-updates main" >> /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ testing-updates main" >> /etc/apt/sources.list;
update_packages;


install_packages --no-install-recommends linux-image-${KARCH} live-boot systemd-sysv -y;

install_packages tzdata locales keyboard-configuration console-setup;

dpkg-reconfigure tzdata;
dpkg-reconfigure locales;
dpkg-reconfigure keyboard-configuration;
dpkg-reconfigure console-setup;

install_packages task-desktop task-xfce-desktop;

install_packages firejail ufw cryptsetup lsof extlinux grub-efi-amd64 efibootmgr bash-completion etherwake wakeonlan cifs-utils wget figlet mpv yt-dlp vim-gtk3 redshift irssi nmap nfs-common remmina python3-pip ffmpeg debootstrap squashfs-tools xorriso syslinux-efi grub-pc-bin grub-efi-amd64-bin mtools dosfstools chrony python3-venv isolinux rsync mutt gimp openvpn netselect-apt gvfs-backends dnsutils xfce4-notes-plugin;

wget ${LWPATH}/librewolf-${LWVER}.en-US.linux-${LWARCH}.tar.bz2;
tar -xf librewolf-${LWVER}.en-US.linux-${LWARCH}.tar.bz2 -C /usr/lib;
rm librewolf-${LWVER}.en-US.linux-${LWARCH}.tar.bz2;

ln -s /usr/lib/librewolf/librewolf /usr/bin/librewolf;

update-alternatives --remove x-www-browser /usr/bin/firefox-esr;
update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/lib/librewolf/librewolf 70;

#head -1 /etc/apt/sources.list | tee /etc/apt/sources.list.d/xfce4-notes-plugin.list;
#sed -i 's/testing/experimental/' /etc/apt/sources.list.d/xfce4-notes-plugin.list;
#apt update;
#apt install xfce4-notes-plugin -y;
#rm /etc/apt/sources.list.d/xfce4-notes-plugin.list;
#apt update;

cd;

#16.08.2023 - z repozytoriów Debian testing został usunięty pakiet picom.
git clone https://github.com/xf0r3m/xfcedebian -b d13;
cd xfcedebian;
bash install.sh;

cd;

cp -vv ~/immudex-testing/tools/immudex-autostart-x4notes /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-create-media /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-addons /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-branch /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-crypt /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-hostname /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-install /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-import-gpgkeys /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-import-sshkeys /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-meteo /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-morketsmerke /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-motd2 /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-newsfeed /usr/local/bin;
#cp -vv ~/immudex-testing/tools/immudex-notifier /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-padlock /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-pl /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-secured-firefox /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-shoutcasts /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-version /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-upgrade /usr/local/bin;
cp -vv ~/immudex-testing/tools/immudex-ytplay /usr/local/bin;
cp -vv ~/immudex-testing/tools/library.sh /usr/local/bin;
cp -vv ~/immudex-testing/tools/idle-clic /usr/local/bin;
cp -vv ~/immudex-testing/tools/sync.sh /usr/local/bin;


chmod +x /usr/local/bin/*;

mkdir /etc/skel/.irssi

cp -vv ~/immudex-testing/files/config /etc/skel/.irssi;
cp -vv ~/immudex-testing/files/default.theme /etc/skel/.irssi;
cp -rvv ~/immudex-testing/files/libreoffice /etc/skel/.config;
cp -vv ~/immudex-testing/files/firejail.config /etc/firejail;
#cp -vv ~/immudex-testing/files/Notifier\ -\ distro.desktop /etc/skel/.config/autostart;
cp -vv ~/immudex-testing/files/redshift.conf /etc/skel/.config;
cp -vv ~/immudex-testing/files/redshift.desktop /etc/skel/.config/autostart;
cp -vv ~/immudex-testing/files/terminalrc /etc/skel/.config/xfce4/terminal;
cp -vv ~/immudex-testing/files/xfce4-keyboard-shortcuts.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml
cp -vv ~/immudex-testing/files/whiskermenu-1.rc /etc/skel/.config/xfce4/panel;
cp -vv ~/immudex-testing/files/xfwm4.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml;

# Instalacja MIME jest teraz częścią projektu 'xfcedebian'
#cp -vv ~/immudex-testing/files/${VERSION}/mimeapps.list /etc/skel/.config;

cp -rvv ~/immudex-testing/files/sync.sh /usr/share;
cp -vv ~/immudex-testing/files/gtk-main.css /usr/share/xfce4-notes-plugin/gtk-3.0/;
cp -vv ~/immudex-testing/files/librewolf.desktop /usr/share/applications;
cp -vv ~/immudex-testing/files/immudex_hostname.service /etc/systemd/system;

tar -xzvf ~/immudex-testing/files/mozilla.tgz -C /etc/skel;
tar -xf ~/immudex-testing/files/librewolf.tgz -C /etc/skel;
#cp -vv ~/immudex-testing/images/${VERSION}/apply.png /usr/share/icons;
cp -vv ~/immudex-testing/images/rss.png /usr/share/icons;

cp -vv ~/immudex-testing/launchers/16844254192.desktop /etc/skel/.config/xfce4/panel/launcher-5;

systemctl enable immudex_hostname.service;

cat >> /etc/bash.bashrc << EOL
if [ ! -f /tmp/.motd ]; then
/usr/local/bin/immudex-motd2
touch /tmp/.motd;
fi
EOL

echo "alias immudex-chhome='export HOME=\$(pwd)'" >> /etc/bash.bashrc;
echo "alias immudex-changelogs='immudex-upgrade --check --print'" >> /etc/bash.bashrc;
echo "alias immudex-version='immudex-upgrade --myversion'" >> /etc/bash.bashrc;

chmod u+s /usr/bin/ping;

/usr/sbin/ufw default deny incoming;
/usr/sbin/ufw default allow outgoing;
/usr/sbin/ufw enable;

echo "immudex" > /etc/hostname;
echo "127.0.1.1   immudex" >> /etc/hosts;

# Zmiany można umieścić również tutaj jeśli dotyczą one użytkowników lub ich
# plików konfiguracyjnych

recreate_users;
echo "user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "xf0r3m ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;

# Miejsce na twoje zmiany, przed poleceniem 'tidy'
tidy;
