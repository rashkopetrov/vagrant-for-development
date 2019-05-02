#!/usr/bin/env bash

# Check If MailUitls Have Been Installed
if [ -f /home/vagrant/.installed-mailutils ]
then
    echo "Mailutils already installed."
    exit 0
fi

echo "Installing Mailutils"

touch /home/vagrant/.installed-mailutils

apt-get -y install mailutils
