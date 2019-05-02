#!/usr/bin/env bash

# Check If Apache2 Has Been Installed
if [ -f /home/vagrant/.installed-apache2 ]
then
    echo "Apache2 already installed."
    exit 0
fi

echo "Installing Apache2"

touch /home/vagrant/.installed-apache2

usermod -a -G vagrant www-data
apt-get -y  --no-install-recommends install apache2
apt-get -y install libapache2-mod-fcgid libapache2-mod-php7.0 libapache2-mod-php7.1 libapache2-mod-php7.2 libapache2-mod-php7.3
a2enmod proxy \
    proxy_fcgi \
    alias \
    authz_host \
    deflate \
    dir \
    expires \
    headers \
    mime \
    rewrite \
    autoindex \
    negotiation \
    setenvif
rm -f /etc/apache2/sites-enabled/*
rm -f /etc/apache2/sites-available/*

sed -i "s|Listen 80|Listen 8880|g" /etc/apache2/ports.conf
sed -i "s|Listen 443|#Listen 443|g" /etc/apache2/ports.conf

service apache2 stop
service apache2 start
