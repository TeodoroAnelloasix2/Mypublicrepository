# Playbooks

```
Ansible Playbooks provide a repeatable, reusable, simple configuration management and multimachine deployment system that is well suited to deploying complex applications.
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
* Tasks    -> Ansible modules to execute in target hosts
* Handlers -> Handlers are special tasks triggered by notify
* Roles    -> Group of resources that allow user to easily reuse them


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


### Import task from another playbook

```yaml
# external_task.yaml

- name: Ping test
  ansible.builtin.ping:


# my_playbook

- name: Execute imported task
  hosts: all
  remote_user: my_user
  tasks:
  - name: Ping test
    include_tasks: external_task.yaml
```