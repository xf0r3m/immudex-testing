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

function check_distro_commit() {
  versionFile="/run/live/medium/live/version";
  if [ -f $versionFile ]; then
    localVersion=$(cat $versionFile);
    if [ -d /tmp/immudex-testing ]; then
      $(cd /tmp/immudex-testing && git pull -q);
    else
      git clone -q https://git.morketsmerke.org/git/immudex-testing /tmp/immudex-testing;
    fi
    latestVersion=$(cd /tmp/immudex-testing && git log --pretty=oneline | head -1 | cut -d " " -f 1);
    if [ "$1" ] && [ "$1" == "--print" ]; then
      echo "$(cd /tmp/immudex-testing && git log ${localVersion}..${latestVersion})";
    fi
    if [ "$localVersion" = "$latestVersion" ]; then
      return 0;
    else
      return 1;
    fi
  else
    return 255;
  fi
}
