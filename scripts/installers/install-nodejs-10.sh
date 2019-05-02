#!/usr/bin/env bash

# Check If Node.js 10 Has Been Installed
if [ -f /home/vagrant/.installed-nodejs10 ]
then
    echo "Node.js 10 already installed."
    exit 0
fi

echo "Installing Node.js 10"

touch /home/vagrant/.installed-nodejs10

curl -sL https://deb.nodesource.com/setup_10.x | bash -
apt-get -y --no-install-recommends install nodejs

# pngquant pre-build test failed
apt-get -y --no-install-recommends install libpng-dev

# error while loading shared libraries: libGL.so.1: cannot open shared object file: No such file or directory
apt-get -y --no-install-recommends install libgl1-mesa-dev

# install bower
sudo npm install -g bower
