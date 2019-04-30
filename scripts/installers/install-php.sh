#!/usr/bin/env bash

# Check If PHP Has Been Installed
if [ -f /home/vagrant/.installed-php ]
then
    echo "PHP already installed."
    exit 0
fi

touch /home/vagrant/.installed-php

wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -
echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list
apt-get -y update

# PHP 7.0
apt-get -y --no-install-recommends install php7.0 php7.0-cli php7.0-fpm php7.0-common php7.0-curl php7.0-gd php7.0-json php7.0-opcache php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-soap php7.0-zip php7.0-xml php7.0-redis php7.0-pgsql

# PHP 7.1
apt-get -y --no-install-recommends install php7.1 php7.1-cli php7.1-fpm php7.1-common php7.1-curl php7.1-gd php7.1-json php7.1-opcache php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-soap php7.1-zip php7.1-xml php7.1-redis php7.1-pgsql

# PHP 7.2
apt-get -y --no-install-recommends install php7.2 php7.2-cli php7.2-fpm php7.2-common php7.2-curl php7.2-gd php7.2-json php7.2-opcache php7.2-mbstring php7.2-mysql php7.2-soap php7.2-zip php7.2-xml php7.2-redis php7.2-pgsql

# PHP 7.3
apt-get -y --no-install-recommends install php7.3 php7.3-cli php7.3-fpm php7.3-common php7.3-curl php7.3-gd php7.3-json php7.3-opcache php7.3-mbstring php7.3-mysql php7.3-soap php7.3-zip php7.3-xml php7.3-redis php7.3-pgsql

# switch the default PHP to 7.2
update-alternatives --set php /usr/bin/php7.2
update-alternatives --set phar /usr/bin/phar7.2
update-alternatives --set phar.phar /usr/bin/phar.phar7.2
