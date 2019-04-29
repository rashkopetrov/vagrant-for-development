#!/usr/bin/env bash

# Check If Apache2 Has Been Installed
if [ -f /home/vagrant/.installed-apache2 ]
then
    echo "Apache2 already installed."
    exit 0
fi

touch /home/vagrant/.installed-apache2

usermod -a -G vagrant www-data
apt-get -y  --no-install-recommends install apache2
apt-get -y install libapache2-mod-fcgid libapache2-mod-php7.0 libapache2-mod-php7.1 libapache2-mod-php7.2 libapache2-mod-php7.3
a2enmod alias
a2enmod authz_host
a2enmod deflate
a2enmod dir
a2enmod expires
a2enmod headers
a2enmod mime
a2enmod rewrite
a2enmod autoindex
a2enmod negotiation
a2enmod setenvif
rm -f /etc/apache2/sites-enabled/*
rm -f /etc/apache2/sites-available/*
service apache2 restart
