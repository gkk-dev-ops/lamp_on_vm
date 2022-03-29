# !/bin/bash
# run on bare metal on which VM is running
# thanks to https://kevrocks67.github.io/blog/qemu-port-forwarding-using-iptables.html

DEFAULT_METAL_IP = ""
DEFAULT_VM_IP = ""
DEFAULT_LAN_INTERFACE = ""

ERR_NO_DEFAULT_VALUE = 2 
ERR_NO_ROOT_PRIV = 1 

if [ "${DEFAULT_METAL_IP}" = "" ] && [ "${DEFAULT_VM_IP}" = "" ] && [ "${DEFAULT_LAN_INTERFACE}" = "" ]; then
  then echo "Please set any default values for script to run as expected :)";
  exit $ERR_NO_DEFAULT_VALUE;
fi

if [ "$EUID" -ne 0 ];
  then echo "Please run as root";
  exit $ERR_NO_ROOT_PRIV;
fi
if [ -n "$1" ]; then
    METAL_IP=$1
    echo "Bare metal IP: $METAL_IP"
    else
    METAL_IP="${DEFUALT_METAL_IP}"
    echo "Using default bare metal IP $METAL_IP"
fi
if [ -n "$2" ]; then
    VM_IP=$2
    echo "VM IP: $VM_IP"
    else
    VM_IP="${DEFAULT_VM_IP}"
    echo "Using default VM IP $VM_IP"
fi

if [ -n "$3" ]; then
    PORT=$3
    echo "Port IP: $PORT"
    else
    PORT="80"
    echo "Using default port $PORT"
fi
if [ -n "$4" ]; then
    LAN_INTERFACE_NAME=$4
    echo "LAN interface: $LAN_INTERFACE_NAME"
    else
    LAN_INTERFACE_NAME="${DEFAULT_LAN_INTERFACE}"
    echo "Using default LAN interface $LAN_INTERFACE_NAME"
fi

# iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -t nat -A PREROUTING -d $METAL_IP/24 -i $LAN_INTERFACE_NAME -p tcp --dport $PORT -j DNAT --to-destination $VM_IP:$PORT
iptables -I FORWARD -p tcp -d $VM_IP/24 --dport $PORT -m state --state NEW,RELATED,ESTABLISHED -j ACCEPT
