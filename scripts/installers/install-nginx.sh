#!/usr/bin/env bash

# Check If Nginx Has Been Installed
if [ -f /home/vagrant/.installed-nginx ]
then
    echo "Nginx already installed."
    exit 0
fi

echo "Installing Nginx"

touch /home/vagrant/.installed-nginx

usermod -a -G vagrant www-data
apt-get -y --no-install-recommends install nginx
rm -f /etc/nginx/sites-enabled/*
rm -f /etc/nginx/sites-available/*

sed -i "s|include \/etc\/nginx\/sites-enabled\/\*;|include \/etc\/nginx\/sites-enabled\/\*;\n\tserver {\n\t\tlisten 8881;\n\t\tserver_name localhost;\n\t}|g" /etc/nginx/nginx.conf

service nginx stop
service nginx start
