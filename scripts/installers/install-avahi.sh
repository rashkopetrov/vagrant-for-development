#!/usr/bin/env bash

# Check If Git Has Been Installed
if [ -f /home/vagrant/.installed-avahi ]
then
    echo "Avahi already installed."
    exit 0
fi

echo "Installing Avahi"

touch /home/vagrant/.installed-avahi

apt-get -y install avahi-utils
