#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================

# common work block
# add set+e in script to ignore errors
# read this string from right to left, first we create b.txt, then create a.txt,>
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
#get file data to a terminal realtime, follow=name allows do not terminate tail if it SIGHUP'ed
tail --follow=name $logfilename
