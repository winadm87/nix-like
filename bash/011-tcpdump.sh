#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
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
