
BEGIN{

# Print number, then generate a bar graph / progress bar



# INPUT VARIABLE
# =====================================================================



if(low=="")
	{
	print ""
	print " ** Missing -v low=[number]   ** "; failed=1}
if(high=="")
	{
	print ""
	print " ** Missing -v high=[number]  ** "; failed=1}
if(value=="")
	{
	print ""
	print " ** Missing -v value=[number] ** "; failed=1}

if(failed==1)
	{
	print ""
	print "	USAGE:"
	print " (g)awk -f bar.awk -v low=0 -v high=1000 -v value=500"
	print ""	
	print "		REQUIRED VALUES"	
	print ""		
	print "		-v low						- Lowest possible value in the range"	
	print "		-v high						- Highest possible value in the range"	
	print "		-v value					- Actual value in the range"
	print ""			
	print "		OPTIONAL VALUES:   (where variable=default value)"	
	print ""	
	print "		-v REVERSED=0				- Reverse direction of bar filling (left->right or right->left)"
	print "		-v INVERTED=0				- Invert selection =/-"	
	print "		-v DIVISOR=1024		-		- Divide values (1K = 1024 bytes, etc)"
	print "		-v MAX_LENGTH=100			- Length of bar"
	print ""
	exit 1;

	}

# CONFIGURATION
# =====================================================================

MAX_LENGTH = 100
MIN_VALUE = low  # TODO NOT YET IMPLEMENTED. What equations do we need to change? <-----------
MAX_VALUE = high


#if not set by command line
if(REVERSED=="")REVERSED=0
if(INVERTED=="")INVERTED=0
if(DIVISOR=="")DIVISOR=1024


# =====================================================================
#value 
#value=value/DIVISOR
#value=100  #hardcode value for testing
percent=value/MAX_VALUE*100
printf "\t%3dM\t  %d%% \t  [", value, percent

if(INVERTED==0)
	{
	FILLED="="
	UNFILLED="-"
	}else{
	FILLED="-"
	UNFILLED="="
	}

if(REVERSED == 0)
	{
	for(i = 0; i < int(value) / MAX_VALUE * MAX_LENGTH ; i++) 
		printf FILLED

	for(i = int(value) / MAX_VALUE * MAX_LENGTH; i < MAX_LENGTH; i++) 
		printf UNFILLED
	}else{

	#note the INNER section is reversed of the for loop
	for(i = int(value) / MAX_VALUE * MAX_LENGTH; i < MAX_LENGTH; i++) 
		printf FILLED

	for(i = 0; i < int(value) / MAX_VALUE * MAX_LENGTH ; i++) 
		printf UNFILLED
	}

printf "]" 
printf "\n" 

} 
