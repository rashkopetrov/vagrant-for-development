#!/usr/bin/env bash

if [ -f ./config.json ]
then
    cp ./resources/config.sample.json ./config.json
    exit 0
fi

