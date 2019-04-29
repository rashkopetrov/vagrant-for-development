#!/usr/bin/env bash

# Check If Nginx Has Been Installed
if [ -f /home/vagrant/.installed-nginx ]
then
    echo "Nginx already installed."
    exit 0
fi

touch /home/vagrant/.installed-nginx

usermod -a -G vagrant www-data
apt-get -y --no-install-recommends install nginx
rm -f /etc/nginx/sites-enabled/*
rm -f /etc/nginx/sites-available/*
service nginx start
