#!/usr/bin/env bash

# Restart the Apache2 service

echo "Restarting Apache2"

service apache2 stop
service apache2 start
