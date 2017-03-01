#!/bin/bash

# 03-01-2017
# This script creates a mount point between the local file system and a Windows
# network share.
# ~~ Scott Johnson

# Don't let the server argument be empty.
if [ -z "$1" ]; then
   echo "Network server URI not provided. ex: //q.lifecorp.net/data"
   echo "Useage: map-drive.sh <//SERVER/SHARE> </LOCAL/PATH>"
   echo "Example: map-drive.sh //q.lifecorp.net/data /mnt/q"
   exit 1
fi

# Don't let the local directory path argument be empty.
if [ -z "$2" ]; then
   echo "Locally mapped directory not provided. ex: /mnt/q"
   exit 1
fi

# Determines the record in /etc/fstab to search for.
SEARCH="$1 $2"

# Search /etc/fstab for this entry.
RESULT=$( cat /etc/fstab | grep "$SEARCH" )

if [ ! -z "$RESULT" ]; then
    echo $SEARCH is already mapped.
    exit 1
fi


# Check the existance of this directory.
if [ -d "$2" ]; then
   echo "Directory already exists $2"
   exit 1
   
else
    # Create the target directory.
    mkdir $2

    # Check the existance of this directory.
    if [ ! -d "$2" ]; then
        echo "Directory not created $2"
        exit 1
    fi
    
fi

echo "Directory created $2"


# Determines the record settings.
SETTINGS="cifs domain=**WINDOWS_DOMAIN***,credentials=/home/***MY_USER_NAME***/***CREDENTIALS_FILE***,dir_mode=0775,uid=***MY_USER_ID***,gid=***MY_GROUP_ID***,iocharset=utf8,sec=ntlm 0 0 0 0"

# Outputs the full 3 lines to add to /etc/fstab
echo "" >> /etc/fstab
echo "# Added by /usr/bin/map-drive.sh" >> /etc/fstab
echo "$1 $2 $SETTINGS" >> /etc/fstab

mount -a

# Finished successfully!
ls -l $2
echo $2
echo done.
exit 0
