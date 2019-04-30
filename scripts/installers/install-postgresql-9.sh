#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Check If MySQL 8 Has Been Installed
if [ -f /home/vagrant/.installed-postgresql ]
then
    echo "PostgreSQL already installed."
    exit 0
fi

touch /home/vagrant/.installed-postgresql

apt-get -y install postgresql postgresql-contrib
# sudo -u postgres psql

sed -i "s|local   all             all                                     peer|local   all             all                                     trust|g" /etc/postgresql/9.6/main/pg_hba.conf
sed -i "s|host    all             all             127.0.0.1/32            md5|host    all             all             127.0.0.1/32            trust|g" /etc/postgresql/9.6/main/pg_hba.conf
sed -i "s|host    all             all             ::1/128                 md5|host    all             all             ::1/128                 trust|g" /etc/postgresql/9.6/main/pg_hba.conf

echo "listen_addresses='*'" >>/etc/postgresql/9.6/main/postgresql.conf

sudo -u postgres psql -c "CREATE USER 'dbuser' WITH SUPERUSER PASSWORD 'toor';"
