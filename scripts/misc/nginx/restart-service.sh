#!/usr/bin/env bash

# Restart the Nginx service

echo "Restarting Nginx"

service nginx stop
service nginx start
