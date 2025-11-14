#!/bin/bash


#To create new fingerprint
rm -f /etc/ssh/ssh_host_*
sleep 1
ssh-keygen -A

sleep 1
#To start sshd
/usr/sbin/sshd -D