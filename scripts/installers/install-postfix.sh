#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Check If Postfix Have Been Installed
if [ -f /home/vagrant/.installed-postfix ]
then
    echo "Postfix already installed."
    exit 0
fi

touch /home/vagrant/.installed-postfix

apt-get -y install postfix
