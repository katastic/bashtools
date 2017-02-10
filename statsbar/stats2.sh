sensors -u | grep 'input:' | grep -o '.[0-9]\.[0-9]\+' | gawk -f test2
