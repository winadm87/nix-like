#!/bin/bash
#=======================================
# This is just a reminder for some standart bash commands
# Author Artyom Ivanov
# Created at 10.2022
# Version 1.0
#=======================================
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
