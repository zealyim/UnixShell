#!/bin/bash
#description!!!!!!!!!!!!!!!
#author: Zeal Yim

##functions
#display modules and update every 1 seconds
function display_menu
{
	sleepInterval=1
	clear
	#infinite while loop
	while [ true ]; do
		tput cup 0 0
		if [ "$4" = "true" ]; then 
			show_option
		fi
		if [ "$1" = "true" ]; then 
			memory_usage
		fi
		if [ "$2" = "true" ]; then
			disk_space
		fi
		if [ "$3" = "true" ]; then
			process_info
		fi
		sleep $sleepInterval
	done
}
#display memory usage info
function memory_usage
{
	echo "${underline}Memory Usage Information${normal}"
	free -k
	echo
}
#display disk space usage info
function disk_space
{
	echo "${underline}Disk Space Information${normal}"
	df -h
	echo
}
#display process info
function process_info
{
	echo "${underline}Process Information${normal}"
	ps -u
	echo
}
#display option menu
function show_option
{
	echo "${underline}Options${normal}"
	echo 'a) Show/Hide Memory Usage Information'
	echo 'b) Show/Hide Disk Space Information'
	echo 'c) Show/Hide Process Information'
	echo 'o) Show/Hide List of Options'
	echo 'q) Quit'
	echo
}

##main

#variables
memUsage=false
disk=false
psInfo=false
showOp=true
underline=$(tput smul)
normal=$(tput sgr0)

#get user's input until user press 'q'. While waiting for user input, modules are display and update as a background process. Everytime user input a character on the keyboard, the background process is killed and a new background process that display modules is created.
while [ "$input" != "q" ]; do
	display_menu $memUsage $disk $psInfo $showOp&
	displayPID=$!
	#get 1 character each time
	read -n 1 input
	#toggle options
	case "$input" in 
		a) $memUsage && memUsage=false || memUsage=true;;
		b) $disk && disk=false || disk=true;;
		c) $psInfo && psInfo=false || psInfo=true;;
		o) $showOp && showOp=false || showOp=true;;
		*) ;;
	esac
	#kill the old process
	kill -9 $displayPID 1> /dev/null 2> /dev/null	
done

#kill -9 $displayPID 1> /dev/null 2> /dev/null
clear
clear
