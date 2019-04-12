#!/usr/bin/env bash

# Check If Composer Has Been Installed
if [ -f /home/vagrant/.installed-phpunit-6.5 ]
then
    echo "PHPUnit 6.5 already installed."
    exit 0
fi

touch /home/vagrant/.installed-phpunit-6.5

wget https://phar.phpunit.de/phpunit-6.5.phar
chmod +x phpunit-6.5.phar
sudo mv phpunit-6.5.phar /usr/local/bin/phpunit
phpunit --version
