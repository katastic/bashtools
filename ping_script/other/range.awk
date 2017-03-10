

#WOAH WOAH WOAH
# We ONLY USE the dollar sign to refer to $1, $2, etc.
# We DO NOT USE THEM as normal expansion like bash does.

#convert subnet to CIDR


# HEY. The ONLY VALUES POSSIBLE ARE:
# 0, 128, 192, 224, 240, 248, 252, 254, 255
#+0   +1,  +2, +3,  +4,  +5,  +6,  +7,  +8
# CIDR


BEGIN { 
FS = "."
cidr=0
}

{
}
END {
cidr=0

for (i=1; i<=NF; i++)
	{
#	print "trying " $i " in " i " of " NF
	if($i=="128"){
		cidr+=1
		}
	if($i=="192"){
		cidr+=2
		}
	if($i=="224"){
		cidr+=3
		}
	if($i=="240"){
		cidr+=4
		}
	if($i=="248"){
		cidr+=5
		}
	if($i=="252"){
		cidr+=6
		}
	if($i=="254"){
		cidr+=7
		}
	if($i=="255"){
		cidr+=8
		}
	}

print cidr
}

