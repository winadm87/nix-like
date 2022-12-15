#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
# work with firewall block
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --zone=public --permanent --list-services
sudo firewall-cmd --zone=public --add-port=5000/tcp
sudo firewall-cmd --zone=public --list-ports
sudo firewall-cmd --reload
sudo ufw allow ssh
sudo ufw allow 9090/tcp
sudo ufw reload
