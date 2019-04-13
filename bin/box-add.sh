#!/usr/bin/env bash

PACKAGES_DIR="$(dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )")/packages"

PACKAGE_NAME=$1
if [[ ! $PACKAGE_NAME ]]; then
    printf "Invalid Package Name\n"
    printf "The available packages are:"
    ls -l $PACKAGES_DIR | awk '{ r="\t"$9; print r }'
    exit 1
fi

BOX_NAME=$2
if [[ ! $BOX_NAME ]]; then
    printf "Invalid Box Name\n"
    exit 1
fi

PACKAGE_FILE="$PACKAGES_DIR/$PACKAGE_NAME"
if [ ! -f $PACKAGE_FILE ]; then
    printf "The package file does not exists: $PACKAGE_FILE\n"
    exit 1
fi

cd ~/
vagrant box add --name=$BOX_NAME $PACKAGE_FILE
