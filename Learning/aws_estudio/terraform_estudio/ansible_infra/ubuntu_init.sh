#!/bin/bash

set -e

export TERM='xterm'

#Creating user
sudo useradd -m -d "/home/ansible" -s "/bin/bash" -p "$(openssl passwd -6 yourpasswordhere)" ansible

sudo -u ansible mkdir -p /home/ansible/.ssh

sleep 0.5

sudo cp "/home/ubuntu/.ssh/authorized_keys" "/home/ansible/.ssh/"

sleep 0.5
sudo chmod 700 /home/ansible/.ssh

sudo chown ansible:ansible /home/ansible/.ssh/authorized_keys
sudo chmod 600 /home/ansible/.ssh/authorized_keys


for us in $(ls /home);do sudo -u "$us"  echo "export TERM=xterm" >> "/home/$us/.bashrc";done

sudo echo  "ansible ALL=(ALL)	NOPASSWD: ALL" >>  "/etc/sudoers" 
