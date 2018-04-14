#!/bin/bash

#xinput set-prop 13 413 .2
#xinput set-prop 13 511 .2

# Hopefully this will find it correctly.

#case insenitive (otherwise, take off the -i in grep)
mouse_name="Cypress APA Trackpad (cyapa)"
mouse_id=$(xinput | grep -i "$mouse_name" | awk '{print $7}' | tr -dc '0-9')

echo Looking for $mouse_name
echo Found ID $mouse_id

property_name="Scroll Y Out Scale"
echo property_name = \"$property_name\"
property_id=$(xinput list-props $mouse_id | grep -i "$property_name" | awk '{print $5}' | tr -dc '0-9')
value=.2

echo hardware_id = $hardware_id 
echo property_id = $property_id
echo setting that to $value
echo running [$ xinput set-prop $mouse_id $property_id $value]
xinput set-prop $mouse_id $property_id $value

# Scroll Y Out Scale (511):       2.500000
# set to .5 or .2

# was 413 previously.... ugh, WHY U MOVING AROUND? Not 100% positive it's the same name that moved
# but clearly the previous number didn't work anymore.
