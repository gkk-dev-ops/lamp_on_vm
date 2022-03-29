#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
if [ -n "$1" ]; then
    if [ "$1" == "guest" ]; then
    echo "You're on guest maschine"
    ./guest/groupsPermissionsSharedDirs.sh
    ./guest/createExampleUsers.sh
    elif [ "$1" == "host" ]; then
    echo "You're on host maschine"
    ./guest/vmPortForwarding.sh
    echo "Remember to later use ./scripts/host/resetIPtables.sh"
    echo "It will clean you're iptables records and therefore remove"
    echo "vm portforwarding which my brake your internet connection :)"
    else
    echo "Incorect maschine specified try [host/guest]"
    exit -1
    fi
else
    echo "You have to specify maschine type [host/guest]"
fi
