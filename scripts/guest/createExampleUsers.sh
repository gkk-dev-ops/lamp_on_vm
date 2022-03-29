#!/bin/bash
# Creates example users, in to groups, student is belongs to both, but is expiring on 2022-09-30
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
addgroup FK
addgroup KP
useradd -m -G FK --password plsChange FK_Ala
useradd -m -G KP --password plsChange KP_Bobo
useradd -m -G FK --password plsChange FK_Cena
useradd -m -G KP --password plsChange KP_Deer
useradd -m -G KP--password plsChange --expiredate 2022-09-30 STUDENT
usermod -g FK STUDENT