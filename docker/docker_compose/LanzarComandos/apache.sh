#!/bin/bash

echo "Hola desde apache " > /var/www/html/index.html
sleep 1
apachectl -D FOREGROUND