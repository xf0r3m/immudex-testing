#!/bin/bash

function get_debian_branch() {
  if grep -q 'trixie' /etc/os-release; then
    echo "testing";
  else
    echo "stable";
  fi
}

function get_machine_arch() {
  arch=$(uname -m);
  if [ "$arch" = "i686" ]; then
    echo "32";
  else
    echo "64";
  fi
}

function check_distro_version() {
  set -e
  root="/run/live/medium";
  if [ -d ${root}/live ]; then
    if [ -f ${root}/live/version ]; then 
      version=$(cat ${root}/live/version | sed 's/\.//g');
    else version="000";
    fi
    BRANCH=$(get_debian_branch);
    ARCH=$(get_machine_arch);
    if [ ! -f /tmp/ltver ]; then
      wget -q https://ftp.morketsmerke.org/immudex/${BRANCH}/upgrades/latest/${ARCH}/version -O /tmp/ltver;
    fi
	  if [ ! -s /tmp/ltver ]; then sudo rm /tmp/ltver; return 255; fi;
    newVersionTxt=$(cat /tmp/ltver);
    newVersionInt=$(echo $newVersionTxt | sed 's/\.//g');
    if [ $version -lt $newVersionInt ]; then
     exitcode=0;
    else
     exitcode=1;
    fi
  else
    exitcode=255;
  fi
  if [ "$1" ] && [ "$1" = "--print" ]; then
    echo $newVersionTxt;
    return 0;
  fi
  return $exitcode;
}
