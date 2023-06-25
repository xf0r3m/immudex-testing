#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-testing.git;
else apt install git && git clone https://github.com/xf0r3m/immudex-testing.git;
fi
source ~/immudex-testing/versions/template.sh;

update_packages;

cp -vv ~/immudex-testing/tools/${VERSION}/immudex_addons /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/immudex_hostname /usr/local/bin;
cp -vv ~/immudex-testing/tools/${VERSION}/pl /usr/local/bin;

set_mime;

tidy;

rm $0;
