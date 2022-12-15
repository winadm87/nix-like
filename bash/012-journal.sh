#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
# journal block
# get logs
journalctl -xe
# get current boot kernel logs
journalctl -k
# get logs from some unit
journalctl -u open-vm-tools.service
