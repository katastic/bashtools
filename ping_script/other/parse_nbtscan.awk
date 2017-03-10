
# $0 is completee line it appears
# "$1" inside quotes are ignored/not substituted.

# Don't write {print $1 - $3}, that's substituted!
# write {print $1 " - " $3} => text - text2

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
