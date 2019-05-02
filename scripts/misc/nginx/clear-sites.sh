#!/usr/bin/env bash

# Clear The Old Nginx Sites

echo "Clearing Nginx sites"

rm -f /etc/nginx/sites-enabled/*
rm -f /etc/nginx/sites-available/*
