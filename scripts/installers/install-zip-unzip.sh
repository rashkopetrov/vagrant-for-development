#!/usr/bin/env bash

# Check If Zip/Unzip Has Been Installed
if [ -f /home/vagrant/.installed-zip-unzip ]
then
    echo "Zip/Unzip already installed."
    exit 0
fi

touch /home/vagrant/.installed-zip-unzip

apt-get -y --no-install-recommends install zip unzip
