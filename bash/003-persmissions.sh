#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
# work with permissions block
# u -user, g -group, +rw - add permission to read\write
chmod ug+rw test.txt
# suid - run by owner id, u+d
# sgid - run by groupid, g+s
# stickybit - only owner or root can delete file, o+t
