#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
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
