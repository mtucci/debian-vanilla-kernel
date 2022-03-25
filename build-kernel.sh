#!/bin/bash

cd /build
download_url=$(curl -s https://www.kernel.org | grep -A3 '>stable:<' | grep -o 'https://[^"]*')
curl "$download_url" --output kernel.tar.xz
tar xavf kernel.tar.xz
rm kernel.tar.xz
cd linux-[0-9\.]*
cp $(ls -1 /boot/config-* | tail -n1) .config
scripts/config --disable MODULE_SIG
scripts/config --disable DEBUG_INFO
yes "" | make oldconfig
make clean
make -j 20 deb-pkg
cd ..
rm -rf linux-[0-9\.]*
