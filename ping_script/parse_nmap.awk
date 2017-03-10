

# Note we could also do NR==1 {} and NR > 1 {} for specific ones.

BEGIN {}


match($0,/scan report for (.*) \(([[:digit:]].*)\)/,  data){
#	print NR, "A - ", $0
		

	host = data[1]
	ip = data[2]

	ips[ip] = ip;
	hosts1[ip] = host;

	print "host is[", data[1],"]"
	print " - ip is[", data[2],"]"
	}

match($0,/Host is up, received (localhost-response|arp-response)/, method_str){


	method = method_str[1]

	
	methods1[ip] = method;
#
	
#print NR, "B - ",$0
	print " - method is", method_str[1]
	}

match($0,/MAC Address: ([[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]])/, z){

	mac = z[1];

	macs1[ip] = mac;
#	print NR, "C - ",$0
	print " - MAC is [", z[1], "]"
	}

END {
	for(i in ips)
		{
		printf("%15s %30s %17s %18s\n", i, hosts1[i], macs1[i], methods1[i]);
		}
	}
