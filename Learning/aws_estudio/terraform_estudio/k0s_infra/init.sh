#!/bin/bash

set -e 

for u in $(ls /home);do sudo -u "$u" echo "export TERM=xterm" >> "/home/$u/.bashrc";done