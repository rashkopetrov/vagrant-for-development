#!/usr/bin/env bash

# Check If Vim Has Been Installed
if [ -f /home/vagrant/.installed-vim ]
then
    echo "Vim already installed."
    exit 0
fi

echo "Installing Vim"

touch /home/vagrant/.installed-vim

apt-get -y --no-install-recommends install vim
