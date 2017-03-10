
OLDIFS=$IFS

# DURRRR -> Use SINGLE QUOTES IN bash commands so you don't have to escape everything. HOWEVER, bash scripts use double quotes to know when to substitute variables! Duh!




#grab the IP and netmask from ifconfig 
#-----------------------------------------

#select ONLY ONE interface!
#ifconfig wlan0

# HOW DO WE KNOW WHICH INTERFACE TO USE?
# HARDCODE IT FOR NOW because it looks like a MESS
# We COULD scan netstat -r and find the lowest METRIC value but screw that for now.

if [ $# -eq 0 ]; then
    echo "Using default, hardcoded interface wlan0."
    interface="wlan0"
else
    interface="$1"
fi

echo "Using interface [$interface]"

ip=`ifconfig $interface | egrep -oe 'inet addr:([[:digit:]]{1,3}.){3}[[:digit:]]{1,3}' | awk -F: '{print $2}'`

netmask=`ifconfig $interface | egrep -oe 'Mask:([[:digit:]]{1,3}.){3}[[:digit:]]{1,3}' | awk -F: '{print $2}'`


IFS=. read -r i1 i2 i3 i4 <<< "$ip"
IFS=. read -r m1 m2 m3 m4 <<< "$netmask"
network=`printf "%d.%d.%d.%d\n" "$((i1 & m1))" "$((i2 & m2))" "$((i3 & m3))" "$((i4 & m4))"`

echo "ip=$ip"
echo "netmask=$netmask"
echo "network=$network"


# you know, at this point we could just compute the damn CIDR value
# instead of using ipcalc which is an additional, non-std, package.

#Return only the network range
#-----------------------------------------

#cidr_old=`ipcalc "$ip $netmask" | egrep -o "Network:.*([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}/[[:digit:]]{1,3}" | awk '{print $2}'`
#echo "cidr_old=$cidr_old"

range=`echo "$netmask" | awk -f range.awk`
cidr="$network/$range"
output=`nbtscan -vh -s, $cidr | awk -f parse_nbtscan.awk`
echo "range=$range"
echo "cidr=$cidr"
echo "$output"

IFS=$OLDIFS

# ---> SEE DOWNLOADED cidr.sh file for how to compute CIDR
# convert to binary, and then count the bits. Pretty simple, right?
# Subnet MUST be ONEs followed by ZEROS right? It can't be 1101. Only 1110.

# HEY. The ONLY VALUES POSSIBLE ARE:
# 0, 128, 192, 224, 240, 248, 252, 254, 255
#+0   +1,  +2, +3,  +4,  +5,  +6,  +7,  +8
# CIDR


