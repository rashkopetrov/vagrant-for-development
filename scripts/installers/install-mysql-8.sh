#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Check If MySQL 8 Has Been Installed
if [ -f /home/vagrant/.installed-mysql8 ]
then
    echo "MySQL 8 already installed."
    exit 0
fi

touch /home/vagrant/.installed-mysql8

# Disable Apparmor
## See https://github.com/laravel/homestead/issues/629#issue-247524528

sudo service apparmor stop
sudo service apparmor teardown
sudo update-rc.d -f apparmor remove

# Remove MySQL
apt-get -y remove --purge mysql-server mysql-client mysql-common
apt-get -y autoremove
apt-get autoclean

rm -rf /var/lib/mysql
rm -rf /var/log/mysql
rm -rf /etc/mysql

# Add MySQL PPA
wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb
dpkg -i mysql-apt-config_0.8.13-1_all.deb
sed -i 's/mysql-5.7/mysql-8.0/g' /etc/apt/sources.list.d/mysql.list
rm -rf mysql-apt-config_0.8.13-1_all.deb
apt-key adv --keyserver keys.gnupg.net --recv-keys 8C718D3B5072E1F5

# Set The Automated Root Password
debconf-set-selections <<< "mysql-server mysql-server/data-dir select ''"
debconf-set-selections <<< "mysql-server mysql-server/root_password password toor"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password toor"

# configuration fix found on
# https://stackoverflow.com/questions/36979574/mysql-5-7-community-server-non-interactive-apt-install
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/repo-codename select stretch64'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/repo-distro select debian'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/repo-url string http://repo.mysql.com/apt/'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-preview select '
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-product select Ok'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-server select mysql-8.0'
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-tools select '
debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/unsupported-platform select abort'

apt-get -y update
apt-get -y install mysql-server

# Configure MySQL 8 Remote Access
echo "bind-address = 0.0.0.0" | tee -a /etc/mysql/conf.d/mysql.cnf

# Use Native Pluggable Authentication
echo -e "[mysqld]\ndefault_authentication_plugin = mysql_native_password" | tee -a /etc/mysql/conf.d/mysql.cnf
service mysql restart

mysql --user="root" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'toor';"
mysql --user="root" --password="toor" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;"
mysql --user="root" --password="toor" -e "CREATE USER 'dbuser'@'0.0.0.0' IDENTIFIED BY 'toor';"
mysql --user="root" --password="toor" -e "CREATE USER 'dbuser'@'%' IDENTIFIED BY 'toor';"
mysql --user="root" --password="toor" -e "GRANT ALL PRIVILEGES ON *.* TO 'dbuser'@'0.0.0.0' WITH GRANT OPTION;"
mysql --user="root" --password="toor" -e "GRANT ALL PRIVILEGES ON *.* TO 'dbuser'@'%' WITH GRANT OPTION;"
mysql --user="root" --password="toor" -e "FLUSH PRIVILEGES;"
service mysql restart
