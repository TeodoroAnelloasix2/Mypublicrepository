#!/bin/bash

sleep 2 

# Hacer un backup
tar cvzf /tmp/copia.tar.gz /usr/*

# Indicar que ha terminado

echo "End" >/tmp/backup.end 