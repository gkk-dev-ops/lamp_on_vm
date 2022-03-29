#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
for g in FK KP
do
    mkdir /$g
    sudo chown -R root /$g
    sudo chgrp root /$g
    chmod -R 700 /$g
done
