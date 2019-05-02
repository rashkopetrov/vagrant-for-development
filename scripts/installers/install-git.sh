#!/usr/bin/env bash

# Check If Git Has Been Installed
if [ -f /home/vagrant/.installed-git ]
then
    echo "Git already installed."
    exit 0
fi

echo "Installing GIT"

touch /home/vagrant/.installed-git

apt-get -y --no-install-recommends install git
