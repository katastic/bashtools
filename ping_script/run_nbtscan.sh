
# State restoration
# ==========================================================

OLDIFS=$IFS

# Embedded support progams
# ==========================================================


#AWK 1 - get cidr range from netmask
#---------------------------------------------
# read, set display name to '', 
read -d '' awk_range << 'EOF'
BEGIN { 
FS = "."
}

{}

END {
cidr_range=0

for (i=1; i<=NF; i++)
	{
#	print "trying " $i " in " i " of " NF
	if($i=="128"){
		cidr_range+=1
		}
	if($i=="192"){
		cidr_range+=2
		}
	if($i=="224"){
		cidr_range+=3
		}
	if($i=="240"){
		cidr_range+=4
		}
	if($i=="248"){
		cidr_range+=5
		}
	if($i=="252"){
		cidr_range+=6
		}
	if($i=="254"){
		cidr_range+=7
		}
	if($i=="255"){
		cidr_range+=8
		}
	}

print cidr_range
}
EOF

#awk 2 - parse nbtscan output
#---------------------------------------------
read -d '' awk_nbtscan << 'EOF'
BEGIN { FS = ","}

{
	ip[$1] = $1 #NOTE, we use IP to access each

	field[$1] = $2
	value[$1] = $3

	data[$1]["ip"] = $1

	if($3 == "Workstation Service")
		{
		data[$1]["hostname"] = $2
		}

	if($3 == "Domain Name")
		{
		data[$1]["domainname"] = $2
		}

	if($2 == "MAC")
		{
		data[$1]["mac"] = $3
		}
}
END {
	for(x in ip){
		print data[x]["ip"] " - " data[x]["hostname"] " - " data[x]["domainname"] " - " data[x]["mac"]
		}

}
EOF


# BEGIN PROGRAM
# ============================================================

#grab the IP and netmask from ifconfig 
#-----------------------------------------


if [ $# -eq 0 ]; then
    echo "No interface specified, defaulting to wlan0."
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

#Return only the network range
#-----------------------------------------


range=`echo "$netmask" | awk "$awk_range"`
cidr="$network/$range"
output=`nbtscan -vh -s, $cidr | awk "$awk_nbtscan"`
echo "range=$range"
echo "cidr=$cidr"
echo "$output"

# Restore state
# =======================================================

IFS=$OLDIFS


