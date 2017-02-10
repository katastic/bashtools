#!/bin/sh

watch -n 4 "free -wth && echo && ./stats_ram.sh && echo && df -H && echo && sensors -f && echo && ./stats2.sh && echo && echo Press Control-C to exit"

# watch -c shows color
# | grep available -C 5 --color=always    highlight "available"
# but  this isn't working for some reason... adds wierd newlines and NO color
