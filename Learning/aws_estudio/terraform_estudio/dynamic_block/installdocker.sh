#!/bin/bash

set -e


sudo yum update -y
sudo yum install -y docker
sudo usermod -a -G docker ec2-user
sudo systemctl enable docker
sudo service docker start
echo 'export TERM=xterm' >> /home/ec2-user/.bashrc 


## Dynamic block example
# Installing apache
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
