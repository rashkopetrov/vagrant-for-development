#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

if [ -f /home/vagrant/.installed-initial-packages ]
then
    echo "Initial packages already installed."
    exit 0
fi

touch /home/vagrant/.installed-initial-packages

apt-get -y --no-install-recommends install \
  build-essential \
  ca-certificates \
  software-properties-common \
  apt-transport-https \
  make \
  debconf \
  wget \
  curl \
  gnupg \
  gnupg2 \
  gnupg1 \
  rsync \
  dirmngr \
  net-tools \
  htop \
  file
