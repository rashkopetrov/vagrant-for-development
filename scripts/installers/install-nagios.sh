#!/usr/bin/env bash

# source: https://www.digitalocean.com/community/tutorials/how-to-install-nagios-4-and-monitor-your-servers-on-ubuntu-14-04#prerequisites

# Check If Mailhog Has Been Installed
if [ -f /home/vagrant/.installed-nagios ]
then
    echo "Nagios already installed."
    /etc/init.d/nagios start # todo: autostart with VM
    exit 0
fi

echo "Installing Nagios"

touch /home/vagrant/.installed-nagios

useradd nagios
groupadd nagcmd
usermod -a -G nagcmd nagios

apt-get -y install build-essential libgd-dev openssl libssl-dev xinetd apache2-utils unzip

cd ~
curl -L -O https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz
tar xvf nagios-4.1.1.tar.gz
cd nagios-4.1.1
./configure --with-nagios-group=nagios --with-command-group=nagcmd
make all

make install
make install-commandmode
make install-init
make install-config

cd ~
curl -L -O http://nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz
tar xvf nagios-plugins-2.1.1.tar.gz
cd nagios-plugins-2.1.1
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
make
make install

cd ~
curl -L -O http://downloads.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz
tar xvf nrpe-2.15.tar.gz
cd nrpe-2.15
make all
make install
make install-xinetd
make install-daemon-config
service xinetd restart

echo "" >> /usr/local/nagios/etc/nagios.cfg
echo "cfg_dir=/usr/local/nagios/etc/servers" >> /usr/local/nagios/etc/nagios.cfg
mkdir /usr/local/nagios/etc/servers

echo "
define command{
        command_name check_nrpe
        command_line $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
}
" >> /usr/local/nagios/etc/objects/commands.cfg

ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios

sed -i "s|### BEGIN INIT INFO|### BEGIN INIT INFO\n# Default-Start: 2 3 4 5\n# Default-Stop: 0 1 6|g" /etc/init.d/nagios

/etc/init.d/nagios start

htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin password

# /usr/bin/install -c -m 644 sample-config/httpd.conf /etc/apache2/sites-available/nagios.conf

# a2enmod expires cgi
# /etc/init.d/apache2 restart
