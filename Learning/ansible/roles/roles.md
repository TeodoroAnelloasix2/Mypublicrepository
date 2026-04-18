# Roles 

#### https://docs.ansible.com/projects/ansible/latest/playbook_guide/playbooks_reuse_roles.html

```
Roles let you automatically load related vars, files, tasks, handlers, and other Ansible artifacts based on a known file structure. 
After you group your content into roles, you can easily reuse them and share them with other users.



An Ansible role has a defined directory structure with seven main standard directories. You must include at least one of these directories in each role. You can omit any directories the role does not use.
roles/
    common/               # this hierarchy represents a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
        library/          # roles can also include custom modules
        module_utils/     # roles can also include custom module_utils
        lookup_plugins/   # or other types of plugins, like lookup in this case

    webtier/              # same kind of structure as "common" was above, done for the webtier role
    monitoring/           # ""
    fooapp/               # ""
```

### Ansible-galaxy

```sh
# To create a role
# https://docs.ansible.com/projects/ansible/latest/cli/ansible-galaxy.html

ansible-galaxy init dev_wordpress_role
- Role dev_wordpress_role was created successfully
```

### Variables priority

```javascript
1. role defaults (lowest priority - easiest to override)
2. inventory group_vars
3. inventory host_vars
4. playbook group_vars
5. playbook host_vars
6. playbook vars
7. playbook vars_prompt
8. playbook vars_files
9. role vars (higher than playbook vars_files)
10. block vars (only for tasks in block)
11. task vars (only for that task)
12. include_vars
13. set_facts
14. registered vars
15. extra vars (command line -e) (highest priority)
```

### pre/post_tasks

```javascript 
pre_tasks in a playbook will cause those tasks to run before all other tasks, including roles.
post_tasks is the opposite—these tasks will run after all others, including any handlers defined by other tasks
```
```yaml
---
- name: pre_tasks, pro_tasks example
  hosts:
  roles:
    - my_role

  pre_tasks:
  - name: refresh available repository 
    apt:
      update_cache: true
  
  tasks:
  - name:
    debug:
      msg: "My tasks here"

  post_task:
  - name: Final task
    debug:
     msg: "My final task here"
```

```yaml
---
- hosts: webservers
  pre_tasks:
    - name: Disable web server in load balancer
      community.general.haproxy:
        state: disabled
        host: '{{ inventory_hostname_short }}'
        fail_on_not_found: yes
      delegate_to: loadbalancer.example.com
  roles:
    - full_patches
  post_tasks:
    - name: Enable web server in load balancer
      community.general.haproxy:
        state: enabled
        host: '{{ inventory_hostname_short }}'
        fail_on_not_found: yes
      delegate_to: loadbalancer.example.com
```

### include_role / import_role sentence

```
https://www.ansiblejunky.com/blog/ansible-101-include-vs-import/
``` 