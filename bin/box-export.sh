#!/usr/bin/env bash

cd "$(dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )")"
mkdir -p packages
BOX_NAME="$(date +'%Y-%m-%d_%T').box"
vagrant package --output=./packages/$BOX_NAME
