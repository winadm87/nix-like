#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
# xargs block
# write echo
ll | xargs
# archive all files with .yml in folder, -print0 show full paths
find ./ansible -name *.yml -type f -print0 | xargs -0 tar -cvzf ansible-playbooks.tar.gz
# show all users in system
cut -d: -f1 </etc/passwd | sort | xargs
# find file in directory and delete them
find . -name "net_stats" -type f -print0 | xargs -0 /bin/rm -v -rf "{}"
