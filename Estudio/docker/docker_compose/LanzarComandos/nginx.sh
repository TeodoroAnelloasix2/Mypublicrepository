#!/bin/bash
echo "Hola desde nginx " > /var/www/html/index.html
sleep 1
nginx -g "daemon off;"