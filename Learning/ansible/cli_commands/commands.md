# Ansible Cli commands

### Ping module

```
Test module used to verify the ability to login and that a usable python is configured on remote nodes 
``` 
```shell

ansible -i server_list all -m ping --key-file key.pem -u user -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"



ansible -i server_list 44.203.105.253 -m ping --key-file key.pem -u user -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"

# Ansible allow us to use meta character like 44.* 
```

### Command module

```
This module take a command name follweb by a list of space delimeted arguments and then
the given command will be executed.
If we need to process command through the shell we need to use "shell" module
```

```shell
ansible -i server_list all -m command -a "date" --key-file key.pem -u user -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"

-m command -a "date"
-m command -a "ls -la"
-m command -a "touch hola.txt"
```

### shell module
```
This built in module allow us to execute commando through the shell /bin/sh
```
```shell
ansible -i server_list 44.* -m shell -a "hostname && whoami " --key-file key.pem -u user -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"

-m shell -a "echo 'hi from master ' > hola.txt && cat hola.txt"
```

### setup module
```
Setup module is used to gather useful facts variables about the system on remote nodes
```

```shell
ansible -i server_list 44.203.105.253  --key-file key.pem -u user -m setup
```



### Copy module

```
This module can be used to copy a file or a directory between two different nodes
```

```shell
ansible -i server_list all  -u user --key-file key.pem -m copy -a "src=file.pdf  dest=/tmp/test2.pdf  mode=660"

```

### yum / apt  module

```
Manages packages:

Installs, upgrade, downgrades, removes, lists etc...
```

```shell
ansible 100.* -i server_list -u user  --key-file key.pem -m yum -a "name=httpd state=present"  -b
# use -b or --become or -b --become-user=root to run the operations as root 

-m yum -a "name=mariadb105-devel.x86_64 state=present"  --become-user='root' -b

-m apt -a "name=apache2 state=present update_cache=true" -b
# update_cache=true -> Run the equivalent of apt-get update before the operation.
```

### service module

```
```

```shell
ansible 100.* -i servers_list -u user  --key-file key.pem -m service -a "name=httpd state=started " -b
```