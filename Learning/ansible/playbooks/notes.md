# Playbooks

```
```

```javascript
Playbook
│
├── Play 1
│   │
│   ├── Task 1
│   ├── Task 2
│   └── Task 3
│
└── Play 2
    │
    ├── Task 1
    └── Task 2     
```

### Playbooks 


* Hosts    -> Target hosts
* Vars     -> Variables used by the current play
* Tasks    -> actions to execute in target hosts
* Handlers -> task that only will be executed if any changes os detected
* Roles    -> 


### Simple playbook example

```yaml
--- # Start of file inside the playbook

##################################
# First play
- name: Update web servers # Play's name
  hosts: webservers        # target
  remote_user: root        

  tasks:  # Task to run
  - name: Ensure apache is at the latest version # Task's name
    ansible.builtin.yum:  # module
      name: httpd         # arguments
      state: latest

  - name: Write the apache config file # Task 2
    ansible.builtin.template:
      src: /srv/httpd.j2
      dest: /etc/httpd.conf
# End of first play
#################################
- name: Update db servers 
  hosts: databases
  remote_user: root

  tasks:
  - name: Ensure postgresql is at the latest version
    ansible.builtin.yum:
      name: postgresql
      state: latest

  - name: Ensure that postgresql is started
    ansible.builtin.service:
      name: postgresql
      state: started
```

### Execute playbook

```shell
ansible-playbook mi_playbook.yaml
```