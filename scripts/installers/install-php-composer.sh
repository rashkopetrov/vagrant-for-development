#!/usr/bin/env bash

# Check If Composer Has Been Installed
if [ -f /home/vagrant/.installed-php-composer ]
then
    echo "Composer already installed."
    exit 0
fi

touch /home/vagrant/.installed-php-composer

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer
composer self-update
