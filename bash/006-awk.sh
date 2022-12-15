#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
# awk block
# get connections, awk result to get tcp and print
netstat -anp | awk '/tcp/ {print}'
#^get connections   ^filter  ^show them
sudo netstat -anp | awk '/tcp/ {print $5}'
#                                      ^ show 5 column - ip address
sudo netstat -anp | awk '$1=="tcp" {print $5}'
# same as previous command but whithout ipv6
sudo netstat -anp | awk '$1=="tcp" {print $5}' | awk -F:               '{print $>
# whithout port                                       ^delimieter key  ^ only fi>
sudo netstat -anp | awk '$1=="tcp" {print $5}' | awk -F: '{print $1}' | sort | u>
#                                                                              ^>
sudo sysctl -a | awk '/vm/ {print}' | awk -F= '{print $1}'
cat /var/log/auth.log | awk '/sudo/ {print}' | awk '/opened/ {print $13}' | sort>
ll | awk '$9!~"/"          {print $9 " " $5}' | sort -k2 -n
#         ^except folders  filename^     ^size        ^by size
systemctl list-units --type=service | awk '/running/ {print}'
