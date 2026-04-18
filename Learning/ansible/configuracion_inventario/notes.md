# Ansible configuration settings


### ansible.cfg

```
This configuration settings file called ansible.cfg allow users to set ansible's behavior
```
### Location-based prority

1. Environment variable "ANSIBLE_CONFIG"
2. Current directory Ansible.cfg
3. User home dir ~/.ansible.cfg
4. /etc/ansible/ansible.cfg


### Generating a sample ansible.cfg file

```
You can generate a fully commented-out example ansible.cfg file, for example:
```
```shell
ansible-config init --disabled > ansible.cfg
```
```
You can also have a more complete file that includes existing plugins:
```
```shell
ansible-config init --disabled -t all > ansible.cfg
```
```
You can use these as starting points to create your own ansible.cfg file.

```


# Inventory

```
Ansible automates tasks on managed nodes by using a list or group of list known as inventory.
Your inventory defines the managed nodes you automate and the variables associated with those hosts. 
You can also specify groups.
Groups allow user to reference multiple hosts to target for your automation or to define variables in bulk.
```

```shell
#Basici inventory (INI)
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com
```

```yaml
ungrouped:
  hosts:
    mail.example.com:
webservers:
  hosts:
    foo.example.com:
    bar.example.com:
dbservers:
  hosts:
    one.example.com:
    two.example.com:
    three.example.com:
```


