#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
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
