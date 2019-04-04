#!/bin/bash


# Install EPEL repository
yum install -y epel-release

# Install Ansible
yum install -y ansible

# Disable SSH key host checking
sed -i 's/^#host_key_checking = False$/host_key_checking = False/g' "/etc/ansible/ansible.cfg"
