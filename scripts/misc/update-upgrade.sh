#!/usr/bin/env bash

echo "Updating/Upgrading the packages"

apt-get -y update
apt-get -y dist-upgrade
