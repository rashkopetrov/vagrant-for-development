#!/usr/bin/env bash

# Check If Mailhog Has Been Installed
if [ -f /home/vagrant/.installed-go ]
then
    echo "Go already installed."
    exit 0
fi

echo "Installing Go"

touch /home/vagrant/.installed-go

apt-get -y install golang-go
