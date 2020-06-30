
#KATKO
xmodmap -e "keycode 22 = BackSpace Delete"
# http://www.comptechdoc.org/os/linux/howlinuxworks/linux_hlkeycodes.html
# HOME is 71
# END is 79
# PAGE UP 81
# PAGE DOWN 73
# DURR we want the opposite direction of these.
#133 is SUPER (search key on chromebook)
#37 is control
#64 is alt
#50 is shift
#26 e
#43 h
# WE COULD ADD A KEYPAD TO 
# QWE
# ASD
# ZXC
# + modifier keys
#sort ls by extension (ala directories first)

#rename guake tab name!
# default arg sets to the current directory name. Otherwise, sets it to whatever you tell it.

# ~/Desktop/name tacos for tuesday 
# --> TAB "tacos for tesuday"

# ~/Desktop/name
# --> TAB "Desktop"
# ---------------------------------------------------------------------
	name() 
		{
		val=$(basename "$PWD")
		
		if [[ "$@" != '' ]];then
			val="$@"
		fi;
		
		guake -r "$val"; 
		}   

# ISSUE: Not sure why, but when in sudo -s, this throws error messages (maybe Guake tries to spawn another tab or something. Can't identify the TTY when in root? YEP. ITS A GUAKE BUG.)

# ---------------------------------------------------------------------

	run() { guake -r "\" $@ \""; "$@"; echo I ran ["\"$@\""];}   
# Not quite working yet... run a command AND set the tab name to the command string. It currently only works without extra arguments. ls -l  becomes ls.
# This might have the solution 
# https://stackoverflow.com/questions/7131670/make-a-bash-alias-that-takes-a-parameter 


# COLORIZE OUTPUT
# USAGE:  cat my_file | pyg    COLOR CODE (default to c++ for simplicity sake)
#	or simply:		pyg my_file
# can then pipe to less -R   (need -R to use colors!)
# ---------------------------------------------------------------------------------
	alias pyg="pygmentize -l c++"

dupes()
	{
	echo "$@"
	fdupes -r "$@" | {
		while IFS= read -r file; do
		    [[ $file ]] && du "$file" -h
		done
	} | sort -h
	}


# WHY DOESNT THIS WORK YET. UGHGHHHHHH
rename_ext()
	{
	if [ "$#" -ne 2 ]; then
		echo "Illegal number of parameters [$@]"
	else
		echo "$1" to "$2"
		echo "Length is $@"

	#	find . -iname "*.$1" -print #WORKS

	#	output=$(find . -iname "*.$1" -exec echo '{}' \;) WORKS
		
		args=". -iname "*.$1" -exec rename \'s/*.$1/*.$2/\' {} \;"
		echo "$args"
		
		output=$(echo "$args" | xargs find )
#		echo "[" $output "]"

	#	find . -iname "*.$1" -exec echo '{}' \\;
	# 	rename  's/\.md/\.md2/'
		
	# https://stackoverflow.com/questions/1224766/how-do-i-rename-the-extension-for-a-batch-of-files?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
	#	rename 's/\.html$/\.txt/' *.html	
	# $ find . -iname "*dbg*" -exec rename _dbg.txt .txt '{}' \;
	
	fi
	}


# avaiable lexers
# http://pygments.org/docs/lexers/

# -l 
# c
# cpp
# sh
# d

# ---------------------------------------------------------------------------------

alias what="history | cut -f 2 -d ' ' --complement | sort | uniq" #list unique bash history
alias clone="guake -n `pwd`"
alias ls="ls --color=auto --group-directories-first"
alias lsd="ls --color=auto -d */"
alias lesser="less -r"
alias lessr="less -r"
alias lessre="less -r"
alias pyg="pygmentize"
alias pig="pygmentize"
alias pigger='pygmentize -l d | less -r'
alias pygd="pygmentize -l d"
alias pygsh="pygmentize -l sh"
alias shot="gnome-screenshot -d 2"


# https://www.gnu.org/software/coreutils/manual/html_node/General-output-formatting.html
# The file type indicators are ‘/’ for directories, ‘@’ for symbolic links, ‘|’ for FIFOs, ‘=’ for sockets, ‘>’ for doors, and nothing for regular files.

# -d skip   (on directories, run program, or skip skips)
# -r recursive
# -s suppress errors
# -I ignore binary.
# 2>&1  redirect STDERR to STDOUT so error messages show in line and you don't get zero results and then find out it was all "permission denied."

alias show='grep ".*" -d skip -I -r 2>&1 | pyg -l d' #current directory only
alias showl='grep ".*" -d skip -I -r 2>&1 | pyg -l d | less -r' #current directory only
alias showr='grep ".*" -r -I 2>&1 | pyg -l d' #recursive
alias showrl='grep ".*" -r -I 2>&1 | pyg -l d | less -r' #recursive
export PAGER=most

alias where='which'  #because I mess this up all the time
alias reload='. ~/.bashrc'

#source ./fix_mouse_scrolling.sh

#xinput set-prop 12 264 1.2
# To half fix the new, less sensitive mouse trackpad once I upgraded to Ubuntu 16
# Still not right... either needs acceleration, or it needs something else...
#export PATH="$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH"


