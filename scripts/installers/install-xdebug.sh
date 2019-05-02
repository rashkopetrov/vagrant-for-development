#!/usr/bin/env bash

# Source: https://blog.thamaraiselvam.com/finally-configured-xdebug-with-sublime-text-3-on-ubuntu-17-04-ea19aff56c67

# Check If Xdebug Has Been Installed
if [ -f /home/vagrant/.installed-xdebug ]
then
    echo "Xdebug already installed."
    exit 0
fi

echo "Installing Xdebug"

touch /home/vagrant/.installed-xdebug

wget http://xdebug.org/files/xdebug-2.7.1.tgz
apt-get -y install php-dev autoconf automake
tar -xvzf xdebug-2.7.1.tgz
cd xdebug-2.7.1

function configure_php_cli() {
    echo "" >> /etc/php/$1/cli/php.ini
    echo "; Xdebug" >> /etc/php/$1/cli/php.ini
    echo "zend_extension = /usr/lib/php/$2/xdebug.so" >> /etc/php/$1/cli/php.ini
}

function configure_php_mods() {
    echo $'
zend_extension=/usr/lib/php/{{ZEND_MODULE_API_NO}}/xdebug.so
xdebug.remote_autostart = 1
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_handler = dbgp
xdebug.remote_host = 127.0.0.1
xdebug.remote_log = /tmp/xdebug_remote.log
xdebug.remote_mode = req
xdebug.remote_port = 9000 #if you want to change the port you can change
    ' | sed "s/{{ZEND_MODULE_API_NO}}/$2/g" > /etc/php/$1/mods-available/xdebug.ini
     systemctl restart php$1-fpm
}

ZEND_MODULE_API_NO=$(echo $(phpize) | sed -r 's/.+Zend Module Api No: ([0-9]+).+/\1/gi')
if [[ $ZEND_MODULE_API_NO =~ ^[0-9]+$ ]] ; then
    ./configure
    make
    cp modules/xdebug.so /usr/lib/php/$ZEND_MODULE_API_NO

    configure_php_cli "7.0" $ZEND_MODULE_API_NO
    configure_php_cli "7.1" $ZEND_MODULE_API_NO
    configure_php_cli "7.2" $ZEND_MODULE_API_NO
    configure_php_cli "7.3" $ZEND_MODULE_API_NO

    apt-get -y install php-xdebug

    configure_php_mods "7.0" $ZEND_MODULE_API_NO
    configure_php_mods "7.1" $ZEND_MODULE_API_NO
    configure_php_mods "7.2" $ZEND_MODULE_API_NO
    configure_php_mods "7.3" $ZEND_MODULE_API_NO

    systemctl restart nginx
fi
