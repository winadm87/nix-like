#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
##############################
# common work block
# add set+e in script to ignore errors
# read this string from right to left, first we create b.txt, then create a.txt, then write ls to a.txt. Do in a.txt we will see a.txt and b.txt
ls > a.txt 2> b.txt
#where i am
pwd
#who i am
whoami
# get linux version
uname -a
lsb_release -a
# get core parameters
sudo sysctl -a
# set env variable from shell
export name=student
# alias
sudo nano ~/.bashrc
alias c='clear'
alias move='mv -i'
alias frename='Example/Test/file_rename.sh'
alias c='clear'
alias move='mv -i'
alias frename='Example/Test/file_rename.sh'
# create link
ln -s existing_source_file optional_symbolic_link
##############################

##############################
# work with flows block
# write to file
echo abc > 1
# add to file
echo abc >> 1
# error to file
ls -al abcabc 2> 1
# get info from file
sort < cat file
# standart and error to one file
./a.out >& test.txt
##############################

##############################
# work with permissions block
# u -user, g -group, +rw - add permission to read\write
chmod ug+rw test.txt
##############################

##############################
# work with processes block
# get proccess
ps aux
# get process nice priority
ps -eo pid,ppid,ni,comm
# kill process
sudo kill pid
# kill signal -HUP
sudo kill - HUP pid
#get files opened by a process 
lsof -c cupsd 
lsof -p pid
##############################

##############################
# systemctl block
sudo systemctl status servicename
sudo systemctl reload/restart/stop/start servicename
sudo systemctl mask/unmask servicename
sudo systemctl enable servicename
# create a service
nano /etc/systemd/system/rot13.service
######
[Unit]
Description=ROT13 demo service
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=centos
ExecStart=/usr/bin/env php /path/to/server.php
[Install]
WantedBy=multi-user.target
#######
##############################

##############################
# awk block
# get connections, awk result to get tcp and print
netstat -anp | awk '/tcp/ {print}'
#^get connections   ^filter  ^show them
sudo netstat -anp | awk '/tcp/ {print $5}'
#                                      ^ show 5 column - ip address
sudo netstat -anp | awk '$1=="tcp" {print $5}'
# same as previous command but whithout ipv6
sudo netstat -anp | awk '$1=="tcp" {print $5}' | awk -F:               '{print $1}'
# whithout port                                       ^delimieter key  ^ only first
sudo netstat -anp | awk '$1=="tcp" {print $5}' | awk -F: '{print $1}' | sort | uniq -c
#                                                                              ^count and show uniqc
sudo sysctl -a | awk '/vm/ {print}' | awk -F= '{print $1}'
cat /var/log/auth.log | awk '/sudo/ {print}' | awk '/opened/ {print $13}' | sort | uniq -c | sort -nr
ll | awk '$9!~"/"          {print $9 " " $5}' | sort -k2 -n
#         ^except folders  filename^     ^size        ^by size
systemctl list-units --type=service | awk '/running/ {print}'
###############################

###############################
# filesystem block
# human readable data of disks
df -h
# data of inodes
df -i
# size of folder /ansible
du -sh ansible/
# pseudo-graphic utility about big files\folders
ncdu
# list of disks
sudo fdisk -l
sudo parted -l
# ist of block devices
sudo lsblk
# work with lvm
# extend lvm and extend fs after extending lvm (extending VM disk)
# mount cdrom to dest folder
sudo mount /dev/cdrom dest/
################################

################################
# network block
# list listening ports
ss -tlpn
################################

################################
# grep block
# grep from to commands
grep rw-r <(ls -al zabbix/) <(la -al linux_common/)
################################

################################
# xargs block
# write echo
ll | xargs
# archive all files with .yml in folder, -print0 show full paths
find ./ansible -name *.yml -type f -print0 | xargs -0 tar -cvzf ansible-playbooks.tar.gz
# show all users in system
cut -d: -f1 </etc/passwd | sort | xargs
# find file in directory and delete them
find . -name "net_stats" -type f -print0 | xargs -0 /bin/rm -v -rf "{}"
################################

#get file data to a terminal realtime, follow=name allows do not terminate tail if it SIGHUP'ed
tail --follow=name $logfilename
