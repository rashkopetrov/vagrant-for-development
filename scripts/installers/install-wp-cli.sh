#!/usr/bin/env bash

# Check If Nginx Has Been Installed
if [ -f /home/vagrant/.installed-wp-cli ]
then
    echo "WP-CLI already installed."
    exit 0
fi

echo "Installing WP Cli"

touch /home/vagrant/.installed-wp-cli

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
