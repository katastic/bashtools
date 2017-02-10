{
# Print number, then generate a bar graph / progress bar

# note sensors RAW mode ONLY does celcious

value=$0*9/5+32 #convert C to F

printf "\t%6.2f°F\t (0°F) [", value
# NOTE, 6.2 means 6 TOTAL digits and TWO are decimal. NOT 6 left + 2 right = 8 digits.

MAX_LENGTH = 100
MIN_VALUE = 0  # TODO NOT YET IMPLEMENTED. What equations do we need to change? <-----------
MAX_VALUE = 120

#note we use $0 * 10 so we can use an INTEGER with the tenths digit place ala 1.1, 1.2, 1.3 etc. = 11, 12, 13.
# THIS WAS REMOVEd. TODO. Add this back

for(i = 0; i < int(value) / MAX_VALUE * MAX_LENGTH ; i++) 
	printf "="

#TODO
# NOTE we're getting a rounding error somewhere in here. Is there a round up/down/middle we're missing? (Only rounding down?)
for(i = int(value) / MAX_VALUE * MAX_LENGTH; i < MAX_LENGTH; i++) 
	printf "-"
printf "] (%d°F=Tjmax)", MAX_VALUE 

printf "\n" 
} 
