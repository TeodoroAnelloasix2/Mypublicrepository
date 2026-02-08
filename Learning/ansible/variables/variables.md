# Variables 


**Location of variables in Ansible**


* Environment variables 
* Inventory files
* Playbooks
* Roles
* Special variables(magic, conection,facts)


#### Environment variables

```
You can use the environment keyword at the play, block, or task level to set an environment variable for an action on a remote host.
You can reuse environment settings by defining them as variables in your play and accessing them in a task as you would access any stored Ansible variable.
```
```yaml
# Environment variable defined with environment keyword at the play level
- hosts: all
  remote_user: root
  tasks:
    - name: Install cobbler
      ansible.builtin.package:
        name: cobbler
        state: present
      environment:
        http_proxy: http://proxy.example.com:8080

# Define a global playbook variable to reuse it
- hosts: all
  remote_user: root

  # create a variable named "proxy_env" that is a dictionary
  vars:
    proxy_env:
      http_proxy: http://proxy.example.com:8080

  tasks:

    - name: Install cobbler
      ansible.builtin.package:
        name: cobbler
        state: present
      environment: "{{ proxy_env }}"
```

#### Variables located on inventory files

```
You can define variables that relate to a specific host or group in your inventory.

```

```javascript
//related to a specific host
[atlanta]
host1 http_port=80 maxRequestsPerChild=808
host2 http_port=303 maxRequestsPerChild=909

```
```yaml
atlanta:
  hosts:
    host1:
      http_port: 80
      maxRequestsPerChild: 808
    host2:
      http_port: 303
      maxRequestsPerChild: 909
```

```javascript
//Assigning a variable to many machines: group variables
[atlanta]
host1
host2

[atlanta:vars]
ntp_server=ntp.example.com
proxy=proxy.example.com
```
```yaml
atlanta:
  hosts:
    host1:
    host2:
  vars:
    ntp_server: ntp.example.com
    proxy: proxy.example.com
```
#### Variables located on Playbooks

```
We can define variables directly in a playbook 
```
```yaml
---
- name: Example Playbook
  hosts: all
  vars:
    app_name: "MyApp"
    app_port: 8080
  tasks:

  # using our vairable value {{ app_name }} {{ app_port }} 

```

#### Variables inside roles

```

```
#### Spacial variables

* Magic      ->  
* Facts      -> 
* Connection -> 


## Defining Variables in Separate Variable Files

```yaml
# Variable file (vars/main.yml)
app_name: "MyApp"
app_port: 8080

# Using variable file:

---
- name: Include Variables from File
  hosts: all
  vars_files:
    - vars/main.yml
  tasks:
    - debug:
        msg: "The app name is {{ app_name }} running on port {{ app_port }}"

```

## Group and host variable

```
Group_vars and host_vars are designated directories to automatically apply variables to their respective groups or host

```

```yaml
# Group variables group_vars/webservers.yml:

app_name: "WebApp"

# Host variables (host_vars/web1.yml):

app_port: 8080

```


## Variables FACTS

```
Ansible facts are a collection of data automatically gathered about remote systems during playbook execution.

```

```yaml
# Display gathered information on a playbook level

- name: Print all available facts
  ansible.builtin.debug:
    var: ansible_facts

##################################################

- name: Display system facts
  hosts: all
  tasks:
    - name: Show hostname and default IPv4
      ansible.builtin.debug:
        msg: >
          The system {{ ansible_facts['nodename'] }} has IP {{ ansible_facts['default_ipv4']['address'] }}.
```
```shell
# Display gathered information witm setup builtin module

ansible hosts -m setup -a 'filter=facts_1,facts_2'
ansible 3.227.245.198 -m setup -a 'filter=ansible_system,ansible_proc_cmdline'
```

## Magic variables

```
Ansible automatically creates magic variables to reflect its internal state. 
```

## Connection Variables

```
Connection variables control how Ansible connects to remote hosts during playbook execution. They define the connection type, user, and other related settings.
```


## --extra-vars (cli option)

```shell
ansible-playbook playbook_name.yaml --extra-vars "Variable='My value'" 

# Example
ansible-playbook set_config_ip.yaml --extra-vars "ip='10.10.10.3'" 
```