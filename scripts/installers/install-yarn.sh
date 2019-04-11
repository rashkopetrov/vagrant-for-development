#!/usr/bin/env bash

# Check If Yarn Has Been Installed
if [ -f /home/vagrant/.installed-yarn ]
then
    echo "Yarn already installed."
    exit 0
fi

touch /home/vagrant/.installed-yarn

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# use --no-install-recommends if using NVM
apt-get -y install yarn
