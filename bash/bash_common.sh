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
# suid - run by owner id, u+d
# sgid - run by groupid, g+s
# stickybit - only owner or root can delete file, o+t
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
sudo kill -HUP pid
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
# netcat to check port availability and run some commands after connect
nc -v oilterminal.ru 443
# netcat only to check port avaialability
nc -zv oilterminal.ru 443
# scan multiple ports availability
nc -v -w 2 z 192.168.56.1 22 80
nc -zv 10.0.2.4 1230-1235
# create a listener on port 1234
nc -lv 1234
# host - get dns records
host -a oilterminal.ru
# get exact dns record type
host -t MX google.com.sg
# dig into dns records
dig oilterminal.ru
# http GET request
curl https://oilterminal.ru
# http return only HEADers
curl -I http://oilterminal.ru
# verbose HTTP connection
curl -vI https://oilterminal.ru
# get mac table
arp -a
# network block finish
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

################################
# tcpdump block
# lets start with 443 port monitor
sudo tcpdump -nnSX port 443
# now lets listen only on one interface
sudo tcpdump -i ens33
# now lets look only for communication with one ip
sudo tcpdump host 192.168.126.2
# lets write to file, pcap can be investigated by wireshark
sudo tcpdump -nnSX port 80 -w /home/admin7/Desktop/capture.pcap
# looking only for some ports
tcpdump port 3389
tcpdump src port 1025
# and lets combine
tcpdump -nnvvS src 10.5.2.3 and dst port 3389
tcpdump -nvX src net 192.168.0.0/16 and dst net 10.0.0.0/8 or 172.16.0.0/16
tcpdump dst 192.168.0.2 and src net and not icmp
tcpdump -vv src mars and not dst port 22
# use quotes to ignore brackets
tcpdump 'src 10.0.2.4 and (dst port 3389 or 22)'
# find http agent user agents
tcpdump -vvAls0 | grep 'User-Agent:'
# cleartext get requests
tcpdump -vvAls0 | grep 'GET'
# find http host address
tcpdump -vvAls0 | grep 'Host:'
# lets get some cookies
tcpdump -vvAls0 | grep 'Set-Cookie|Host:|Cookie:'
# !!! lets get ssh connections regardless of port being used
tcpdump 'tcp[(tcp[12]>>2):4] = 0x5353482D'
# find dns traffic
tcpdump -vvAs0 port 53
# find cleartext passwords
tcpdump port http or port ftp or port smtp or port imap or port pop3 or port telnet -lA | egrep -i -B5 'pass=|pwd=|log=|login=|user=|username=|pw=|passw=|passwd= |password=|pass:|user:|username:|password:|login:|pass |user '
# tcpdump block finish
################################

################################
# journal block
# get logs
journalctl -xe
# get current boot kernel logs
journalctl -k
# get logs from some unit
journalctl -u open-vm-tools.service
# journal block finish
################################

################################
# work with firewall block
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --zone=public --permanent --list-services
sudo firewall-cmd --zone=public --add-port=5000/tcp
sudo firewall-cmd --zone=public --list-ports
sudo firewall-cmd --reload
sudo ufw allow ssh
sudo ufw allow 9090/tcp
sudo ufw reload
# work with firewall block finish
################################


