#!/bin/bash

set -e;

if [ "$1" = "64" ]; then
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

apt install -y git firejail ufw cryptsetup lsof extlinux grub-efi-amd64 efibootmgr bash-completion etherwake wakeonlan cifs-utils wget figlet chirp mpv youtube-dl vim-gtk3 redshift 

#apt install -y libssl-dev libbz2-dev libnss3-dev libgdbm-dev libncurses5-dev libffi-dev libreadline-dev libsqlite3-dev zlib1g-dev build-essential;

#apt install --no-install-recommends software-properties-common -y;

#wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tar.xz -O Python-3.11.0.tar.xz;
#tar -xvf Python-3.11.0.tar.xz;
#cd Python-3.11.0;

#./configure --prefix=/usr/local --enable-optimizations
#make
#make altinstall

cp /usr/bin/youtube-dl /usr/bin/youtube-dl-orig;
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/bin/youtube-dl;
chmod +x /usr/bin/youtube-dl;

cd;
git clone https://github.com/xf0r3m/xfcedebian.git;
cd xfcedebian;
chmod +x install.sh;
sed -i 's/sudo//g' install.sh;
bash install.sh;

cd;
git clone https://github.com/xf0r3m/immudex-testing.git;
cd immudex-testing;

tar -xzvf mozilla.tgz -C /etc/skel;
chown -R root:root /etc/skel/.mozilla;

cp -vv tools/* /usr/local/bin;
#cp tools/protected /usr/local/bin;
chmod +x /usr/local/bin/*;

cp -v launchers/16608166085.desktop /etc/skel/.config/xfce4/panel/launcher-19/
cp -v launchers/16674118881.desktop /etc/skel/.config/xfce4/panel/launcher-32/
rm /etc/skel/.config/xfce4/panel/launcher-32/16608177609.desktop
cp -rv launchers/launcher-29 /etc/skel/.config/xfce4/panel;
cp -v files/xfce4-panel.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml;

#sed -i '26s/1/0' /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml;
#sed -i '64i\\\t<property name="disable-struts" type=bool value="false"/>' /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml;

cp -v images/padlock.png /usr/share/images/desktop-base;
cp -v images/unlocked.png /usr/share/images/desktop-base;
cp -v images/rss.png  /usr/share/icons;
cp -v files/redshift.conf /etc/skel/.config;
mkdir -v /etc/skel/.config/autostart;
cp -vv files/redshift.desktop /etc/skel/.config/autostart;

#echo "/usr/local/bin/motd2" >> /etc/bash.bashrc;

echo "if [ ! -f /tmp/.motd ]; then" >> /etc/bash.bashrc;
echo "  /usr/local/bin/motd2;" >> /etc/bash.bashrc;
echo "  touch /tmp/.motd;" >> /etc/bash.bashrc;
echo "fi;" >> /etc/bash.bashrc;

echo "alias chhome='export HOME=\$(pwd)'" >> /etc/bash.bashrc;
echo "alias ytstream='mpv --ytdl-format=best[height=480]'" >> /etc/bash.bashrc;

chmod u+s /usr/bin/ping;
sed -i -e 's/chirpw/sudo chirpw/' -e 's/false/true/' /usr/share/applications/chirp.desktop;

ufw default deny incoming;
ufw default allow outgoing;
ufw enable;
echo "immudex" > /etc/hostname;
echo "127.0.1.1    immudex" >> /etc/hosts;
echo "deb http://ftp.icm.edu.pl/pub/Linux/debian/ bookworm main" > /etc/apt/sources.list;
echo "deb-src http://ftp.icm.edu.pl/pub/Linux/debian/ bookworm main" >> /etc/apt/sources.list;
echo "deb http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list;
echo "deb-src http://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list;
echo "deb http://ftp.icm.edu.pl/pub/Linux/debian/ bookworm-updates main" >> /etc/apt/sources.list;
echo "deb-src http://ftp.icm.edu.pl/pub/Linux/debian/ bookworm-updates main" >> /etc/apt/sources.list;
apt update;
apt upgrade -y;
cd;

useradd -m -s /bin/bash user;
if [ ! -f /home/user/.bashrc ]; then
  cp -rvv /etc/skel/.??* /home/user;
  chown -R user:user /home/user;
fi
echo "user:user1" | chpasswd;

useradd -m -s /bin/bash xf0r3m;
if [ ! -f /home/xf0r3m/.bashrc ]; then
  cp -rvv /etc/skel/.??* /home/xf0r3m;
  chown -R xf0r3m:xf0r3m /home/xf0r3m;
fi
echo "xf0r3m:xf0r3m1" | chpasswd;

echo "xf0r3m ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root:toor" | chpasswd;
usermod -aG libvirt,libvirt-qemu xf0r3m;
usermod -aG libvirt,libvirt-qemu user;
rm -rf immudex-testing/
rm -rf xfcedebian/
#rm -rf /Python-3.11.0;
#rm /Python-3.11.0.tar.xz;
apt-get clean;
apt-get clean;
apt-get autoclean;
#apt remove -y libssl-dev libbz2-dev libnss3-dev libgdbm-dev libncurses5-dev libffi-dev libreadline-dev libsqlite3-dev zlib1g-dev build-essential software-properties-common ;
apt-get autoremove -y;
echo > ~/.bash_history
history -c
