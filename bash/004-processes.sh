#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
# work with processes block
# get proccess
ps aux
# get process nice priority
ps -eo pid,ppid,ni,comm
# kill process
sudo kill pid
# kill signal -HUP
sudo kill -HUP pid
#get files opened by a process 
lsof -c cupsd 
lsof -p pid
