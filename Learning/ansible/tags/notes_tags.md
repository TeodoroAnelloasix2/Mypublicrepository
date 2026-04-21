# Tags

```

https://docs.ansible.com/projects/ansible/latest/playbook_guide/playbooks_tags.html

If you have a large playbook, it may be useful to run only specific parts of it instead of running the entire playbook. You can do this with Ansible tags. Using tags to execute or skip selected tasks is a two-step process:

        Add tags to your tasks, either individually or with tag inheritance from a block, play, role, or import.

        Select or skip tags when you run your playbook.


```

```yaml
---
- name: Handle environment using tags
  hosts: all

  tasks:

  - name: Preparing development environment
    ansible.builtin.debug:
      msg: "This is testing environments"
    tags:
      - development
  
  - name: Preparing production environment
    debug:
      msg: "This is production environments"
    tags: production
  
   - name: Both environment
    ansible.builtin.debug:
      msg: "Installing antivirus on both environment"
    tags:
      - development
      - production
```
```sh
# default option --tags all (implicit)
# To run a specific task with specified tag
ansible-playbook tasks_file.yaml --tags development 
ansible-playbook tasks_file.yaml -t development



# To run multiple tags -> --tags tag1, tag2, tag3 
ansible-playbook tasks_file.yaml --tags development,production 

# To list tags in a spefic playbook
ansible-playbook tasks_file.yaml --list-tags

# To see which tasks will be executed with specifc tag
ansible-playbook separate_environment_example.yaml --list-tasks -t development
```

```yaml
---
- name: Special tags always y never
  hosts: all

  tasks:

  - name: This task will never  be executed
    ansible.builtin.debug:
      msg: "This task will never  be executed"
    tags:
      - never
  
  - name: This task will always run
    debug:
      msg: "This task will always run"
    tags: always


```

### how to tag an entire play

```yaml
--- 
- name: Play 1
  hosts: List_server
  tags: linux
  
  tasks:
  
  - name: This play is tagged as linux
    debug: 
      msg: "Linux task"
  
  - name: Second linux task
    debug: 
      msg: "Linux task"

- name: Play 2
  hosts: List_server2
  tags: windows  
  tasks:
   - name: This play is tagged as windows
    debug: 
      msg: "Windows task"
  
  - name: Second windows task
    debug: 
      msg: "Windows task"



```