#!/usr/bin/env bash

# Check If Nginx Has Been Installed
if [ -f /home/vagrant/.installed-redis ]
then
    echo "Redis already installed."
    exit 0
fi

echo "Installing Redis"

touch /home/vagrant/.installed-redis

apt-get -y install redis-server
systemctl enable redis-server.service
systemctl restart redis-server.service
