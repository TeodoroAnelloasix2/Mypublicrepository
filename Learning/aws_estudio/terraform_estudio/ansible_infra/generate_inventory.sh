#!/bin/bash

f=$1
ubuntu_servers="$(awk '/ubuntu/ { print $1":"}' $f)"
mysql_servers="$(awk '/mysql/ { print $1":"}' $f)"
redhat_servers="$(awk '/redhat/ { print $1":"}' $f)"
aws_servers="$(awk '/aws/ { print $1":"}' $f)"

ungrouped_ip="$(echo $ubuntu_servers | tail -n 1 | awk '{print $1}')"
INV_YAML="inventory.yaml"    
INV_INI="inventory"
cat > $INV_YAML <<- EOM

ungrouped:
  hosts:
    $ungrouped_ip
  vars:
    ansible_user: ansible
ubuntu_server:
  hosts:
    $ubuntu_servers
  vars:
    ansible_user: ansible
mysql:
  hosts:
    $mysql_servers
  vars:
    ansible_user: ansible
aws_linux:
  hosts:
    $aws_servers
  vars:
    ansible_user: ansible
redhat_srv:
  hosts:
    $redhat_servers
  vars:
    ansible_user: ansible
EOM

ubuntu_servers2="$(awk '/ubuntu/ { print $1}' $f)"
mysql_servers2="$(awk '/mysql/ { print $1}' $f)"
redhat_servers2="$(awk '/redhat/ { print $1}' $f)"
aws_servers2="$(awk '/aws/ { print $1}' $f)"

cat > $INV_INI <<- EOM
[ubuntu_server]
$ubuntu_servers2

[mysql]
$mysql_servers2

[redhat_srv]
$redhat_servers2

[aws_linux]
$aws_servers2
EOM