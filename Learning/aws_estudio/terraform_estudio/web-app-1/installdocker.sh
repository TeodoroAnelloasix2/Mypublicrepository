#!/bin/bash

set -e


sudo yum update -y
sudo yum install -y docker
sudo usermod -a -G docker ec2-user
sudo systemctl enable docker
sudo service docker start
echo 'export TERM=xterm' >> /home/ec2-user/.bashrc #This is for me because i use kitty!!! You can ignore it