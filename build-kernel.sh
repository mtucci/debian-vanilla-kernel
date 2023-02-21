#!/bin/bash

if [[ $# -ne 1 ]]
then
    # If no argument is passed, get the latest stable
    download_url=$(curl -s https://www.kernel.org | grep -A3 '>stable:<' | grep -o 'https://[^"]*')
else
    download_url="https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-${1}.tar.xz"
fi

# Download and unpack
cd /build
curl "$download_url" --output kernel.tar.xz
tar xavf kernel.tar.xz
cd linux-[0-9\.]*

# Config and compile
cp /config .config
scripts/config --disable MODULE_SIG
scripts/config --disable DEBUG_INFO
yes "" | make oldconfig
make clean
make -j 20 deb-pkg
cd ..

# Clean up
rm kernel.tar.xz
rm -rf linux-[0-9\.]*
