# !/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

while true
do
    echo "Computer will be rebooted to aply changed settings"
    read -r -p 'Do you want to continue? [y/n]' choice
    case "$choice" in
      n|N) break;;
      y|Y) echo 'Do your stuff here'
      iptables -P INPUT ACCEPT
      iptables -P INPUT ACCEPT
      iptables -P INPUT ACCEPT
      iptables -F INPUT
      iptables -F OUTPUT
      iptables -F FORWARD
      iptables -F
      reboot
      echo "Done"
      exit
      ;;
      *) echo 'Response not valid';;
    esac
done
