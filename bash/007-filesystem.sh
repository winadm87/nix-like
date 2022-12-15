#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
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
