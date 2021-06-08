# https://gist.github.com/jagtesh/5531300

echo "=== Script Start ==="

# Add one IP to the list of split tunnel
add_ip() {
  export CISCO_SPLIT_INC_${CISCO_SPLIT_INC}_ADDR=$1
  export CISCO_SPLIT_INC_${CISCO_SPLIT_INC}_MASK=255.255.255.255
  export CISCO_SPLIT_INC_${CISCO_SPLIT_INC}_MASKLEN=32
  export CISCO_SPLIT_INC=$(($CISCO_SPLIT_INC + 1))
}

# Initialize empty split tunnel list
export CISCO_SPLIT_INC=0

# Delete DNS info provided by VPN server to use internet DNS
# Comment following line to use DNS beyond VPN tunnel
unset INTERNAL_IP4_DNS

# List of IPs beyond VPN tunnel
add_ip 34.117.59.81 # curl ifconfig.me
# curl api.ipify.org

export CISCO_BANNER="=== My Banner ==="

echo "=== Execute Default ==="

# Execute default script
. /usr/share/vpnc-scripts/vpnc-script

echo "=== Script End ==="
