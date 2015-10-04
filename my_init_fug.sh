#!/bin/bash

VOLUME=/ftp
OWNER_USERNAME=ftp
OWNER_GROUPNAME=ftp

NEWUID=$(ls --numeric-uid-gid -d $VOLUME | awk '{ print $3 }')
NEWGID=$(ls --numeric-uid-gid -d $VOLUME | awk '{ print $4 }')

if [ $NEWUID -eq 0 ]; then
  OWNER_USERNAME=root
else
  usermod -u $NEWUID $OWNER_USERNAME
fi

if [ $NEWGID -eq 0 ]; then
  OWNER_GROUPNAME=root
else
  groupmod -g $NEWGID $OWNER_GROUPNAME
fi

/sbin/my_init
