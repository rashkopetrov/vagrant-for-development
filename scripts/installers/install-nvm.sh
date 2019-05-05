#!/usr/bin/env bash

# source: https://stackoverflow.com/a/27429191/6334871

# Check If NVM Has Been Installed
if [ -f /home/vagrant/.installed-nvm ]
then
    echo "NVM already installed."
    exit 0
fi

echo "Installing NVM"

touch /home/vagrant/.installed-nvm

apt-get -y remove --purge nodejs

sudo -i -u vagrant bash << EOF
cd /home/vagrant

# Installing nvm
wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh

# This enables NVM without a logout/login
export NVM_DIR="/home/vagrant/.nvm"
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads nvm

# Install a node and alias
#nvm install 10.15.3
#nvm alias default 10.15.3

# You can also install other stuff here
#npm install -g bower ember-cli
EOF

exit 0
