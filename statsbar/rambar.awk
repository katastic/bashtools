{
# Print number, then generate a bar graph / progress bar



# CONFIGURATION
# =====================================================================

MAX_LENGTH = 100
MIN_VALUE = 0  # TODO NOT YET IMPLEMENTED. What equations do we need to change? <-----------
MAX_VALUE = 1024
REVERSED=1
INVERTED=0
DIVISOR=1024


# =====================================================================
value=$0 
value=value/DIVISOR
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
	for(i = int(value) / MAX_VALUE * MAX_LENGTH; i < MAX_LENGTH; i++) 
		printf FILLED

	for(i = 0; i < int(value) / MAX_VALUE * MAX_LENGTH ; i++) 
		printf UNFILLED
	}

printf "]" 
printf "\n" 

} 
