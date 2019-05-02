#!/usr/bin/env bash

# Clear The Old Apache2 Sites

echo "Clearing Apache2 sites"

rm -f /etc/apache2/sites-enabled/*
rm -f /etc/apache2/sites-available/*
