#!/bin/bash

# write numbers to log.log file, with opened descriptor
# on 'kill -SIGHUP pid' we have to close descriptor
# rename log file, open new one and go on with 
# numbers filling. and with tail to

# set variable for log file name
DEFAULTVALUE=log.log
# if not set - choose default
logfilename="${1:-$DEFAULTVALUE}"

# rotating file if exists, add timestamp to old filename
function log_rotate {
    if [ -f "$logfilename" ]
    then mv $logfilename $logfilename.$(date +%Y%m%d_%H%M%S)
    fi
}

# call func to rotate log file if it already exists
log_rotate

# func to write numbers to log file
# also, we anounce filedescriptor for the file...
function write_to_log {
        while :
        do
        # right here
        exec 3<> $logfilename
                for (( c=1; ; c++ ))
                do
                        echo $c >> $logfilename
                        sleep 1
                done
        done
}

# cach HUP signal, close file descriptor, call lof rotate func
trap "exec 3>&- ;log_rotate" SIGHUP

# run tail to terminal
tail --follow=name $logfilename 2> &
# run func about numbers
write_to_log
