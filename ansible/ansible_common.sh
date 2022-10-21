#!/bin/bash
#==============================
# Ansible how-to
# Auhtor Ivanov Artyom
# Create on 10.2022
# Version 1.0
#===============================
# ansible - push
# create a user on master and nodes
# sudo useradd -m ansibleuser
# on master - su - ansibleuser
# on master - ssh-keygen
# on master - ssh-copy-id ansibleuser@nodeip

# mkdir ansible
# nano hosts.txt
#[prod_servers]
#srv-test2 ansible_host=192.168.126.132
#srv-deb1 ansible_host=192.168.126.139
#[prod_servers:vars]
#ansible_user=ansibleuser
#ansible_ssh_private_key_file=/home/ansibleuser/.ssh/id_rsa
ansible -i hosts.txt all -m ping

# create config file
# nano ansible.cfg
#[defaults]
#host_key_checking = false #dont show ssh key fingerprint alert on first connect
#inventory = ./hosts.txt
ansible all -m ping

# check ansible inventory
ansible-inventory --list
ansible-inventory --graph

# get usefull information about remote host
ansible srv-test2 -m setup

# run shell command on remote hosts
ansible all -m shell -a "pwd"
# run command WITHOUT shell, next command will fail
ansible all -m command -a "printenv | grep SHELL"

# ubuntu -> add ansibleuser on remote host write to sudouser
# nano /etc/sudoers.d/ansibleuser --> ansibleuser ALL=(ALL) NOPASSWD:ALL

# centos -> 
# useradd ansibleuser
# passwd ansibleuser
# usermod -aG wheel ansibleuser
# visudo ->
# uncomment: %wheel        ALL=(ALL)       ALL
# add: ansibleuser ALL=(ALL) NOPASSWD: ALL
# nano /etc/sudoers.d/ansibleuser --> ansibleuser ALL=(ALL) NOPASSWD:ALL
# reboot


# next we can copy dile from master to remote hosts
ansible all -m copy -a "src=master.txt dest=/home mode=777" -b
#              ^module  ^source        ^destination          ^become sudo  
# remove file from remote host
ansible all -m file -a "path=/home/master.txt state=absent" -b
#              ^module  ^path to file               ^remove  ^become sudo
# download file from internet
ansible all -m get_url -a "url=https://thisisurl dest=/home" -b
#              ^module         ^url of file      ^destination ^become sudo

# install on ubuntu\debian
ansible all -m apt -a "name=mc state=latest" -b
#              ^command     ^prog    ^to install
# remove on ubuntu\debian
ansible all -m apt -a "name=mc state=absent" -b

# read some url on remote host
ansible all -m uri -a "url=https://yandex.ru"
# read some url and return content
ansible all -m uri -a "url=https://yandex.ru return_content=yes"

# start and enable service
ansible all -m servie -a "name=httpd state=started enabled=yes" -b
#              ^module         ^service    ^start          ^enable autoload

# get super verbose of ansible run
ansible all -m shell -a "ls -al /home" -vvv
#                                      ^super verbose key     
  
# move group vars to separate file from inventory (hosts.txt)
mkdir group_vars
cd group_vars
nano prod_servers
############
#---
#ansible_user                    : ansibleuser
#ansible_ssh_private_key_file    : /home/ansibleuser/.ssh/id_rsa
############
# check that vars are visible
ansible-inventory --list


# our first playbook
nano playbook1.yml
#======================
---
- name: test connection to my servers #name of playbook
  hosts: all  #what hosts to run at
  become: yes #run as sudo

  tasks:
  - name: Ping my servers #name of the task
    ping: #command to run, oing doesnt need parameters
#======================
# and run the playbook file with
ansible-playbook playbook1.yml

# second playbook
nano playbook2.yml
=====================
---
- name: Install webserver apache
  hosts: srv-cent1
  become: yes

  tasks:
  - name: Install apache webserver
    yum: name=httpd state=latest

  - name: Start apache and enable
    service: name=httpd state=started enabled=yes 
======================

# third playbook
=======================
---
- name: copy index.html to srv-cent1
  hosts: srv-cent1
  become: yes

  tasks:
  - name: copy file from local to remote server
    copy: src=index.html dest=/var/www/html/index.html
========================

# and once more, little bit complicated
========================
---
- name: install apache and copy all folder to remote server
  hosts: prod_servers
  become: yes

  vars:
    source_file: ./mywebsite/index.html
    destination_file: /var/www/html

  tasks:
  - name: install apache to prod servers
    apt: name=apache2 state=latest

  - name: copy index html
    copy: src={{ source_file }} dest={{ destination_file }} mode=>
    notify: restart apache

  - name: start webservice and enable
    service: name=apache2 state=started enabled=yes

  handlers:
  - name: restart apache
    service: name=apache2 state=restarted
============================

# working with variables inside a playbook
==============================
  GNU nano 6.2                                                         playbook7.yml                                                                  
---
- name: for variables test
  hosts: prod_servers
  become: yes

  vars:
    message1: hi
    message2: goodbye
    secret: supestronghash

  tasks:
  - name: print secret variable
    debug:
      var: secret

  - name: print once more
    debug:
      msg: "show variable {{ secret }}"

  - name: and again
    debug:
      msg: "vladelec etogo servera --> {{ owner }}"

  - name: two variables
    set_fact: full_message="{{ message1 }} {{ message2 }} from {{ owner }}"

  - name: debug again
    debug:
     msg: "{{ full_message }}"

  - name: debug for global variables
    debug:
     var: ansible_distribution

  - name: write to variable from remote host
    shell: cat /etc/fstab
    register: fstabchik

  - name: print from variable
    debug:
     var: fstabchik

  - name: try again with ipv4
    debug:
     var: ansible_ens33.ipv4

==============================

# all of this "ansible all -m setup"
# can be used as variables in playbooks

# now lets use block-when
=========================================================
---
- name: install apache and copy all folder to remote server
  hosts: all
  become: yes
  vars:
    source_file: ./mywebsite/index.html
    destination_file: /var/www/html

  tasks:
  - name: check and print linux version
    debug: var=ansible_os_family

  - block: #block for debian

     - name: install apache for debian
       apt: name=apache2 state=latest

     - name: copy index html for debian
       copy: src={{ source_file }} dest={{ destination_file }} mode=0555
       notify: restart apache

     - name: start webservice and enable for debian
       service: name=apache2 state=started enabled=yes
    when: ansible_os_family == "Debian"

  - block: #block for redhat

     - name: install apache for centos
       yum: name=httpd state=latest

     - name: copy index html for redhat
       copy: src={{ source_file }} dest={{ destination_file }} mode=0555
       notify: restart httpd

     - name: start webservice and enable for redhat
       service: name=httpd state=started enabled=yes
    when: ansible_os_family == "RedHat"

  handlers:
  - name: restart apache
    service: name=apache2 state=restarted
  - name: restart httpd
    service: name=httpd state=restarted
========================================================

# once again with block-when
========================================================
- name: test with blocks
  hosts: all
  become: yes

  vars:
   soft_to_install: net-tools
   command_to_execute: ip a | grep inet

  tasks:
  - block: #for redhat systems
     - name: install net-tools
       yum: name="{{ soft_to_install }}" state=latest
     - name: write to variable
       shell: "{{ command_to_execute }}"
       register: ip_a
     - name: print ip_a variable
       debug:
        var: ip_a.stdout
    when: ansible_os_family == "RedHat"
  - block: #for debian systems
     - name: install net-tools 
       apt: name="{{ soft_to_install }}" state=latest
     - name: write to variable
       shell: "{{ command_to_execute }}"
       register: ip_a
     - name: print ip_a variable
       debug:
        var: ip_a.stdout
    when: ansible_os_family == "Debian"
==========================================================


# lets try some roles
mkdir roles
cd roles
ansible-galaxy init deploy_apache

# run playbook with extra-vars
ansible-playbook playbook-deploy_apache.yml --extra-vars "MYHOSTS=prod_servers"
nano playbook-deploy_apache.yml
==================
---
- name: install apache and copy all folder to remote server
  hosts: "{{ MYHOSTS }}"
  become: yes

  roles:
   - { role: deploy_apache, when: ansible_system == 'Linux' }
=================

# create vault file
ansible-vault create mysecret.txt
# read vault file
ansible-vault view mysecret.txt
# edit vault file
ansible-vault edit mysecret.txt
# run ecrypted playbook
ansible-playbook playbook_vault.yml --ask-vault-pass






