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
		#place cursor at top left
		tput cup 0 0
		#display modules
		if [ "$1" = "true" ]; then
			dis_header
		fi
		if [ "$2" = "true" ]; then 
			cpu_graph
		fi
		if [ "$3" = "true" ]; then
			mem_graph
		fi
		if [ "$4" = "true" ]; then
			process_info
		fi
		if [ "$5" = "true" ]; then 
			show_option
		fi
		sleep $sleepInterval
	done
}
#display header
function dis_header
{
	printf "%s " $(date +"%r") 
	printf "CPU: %s%% MEM: %s K total, %s K free \n" $(top -n1 -b | grep "%Cpu" | awk -F" " '{print $2 + $4}' ) $(top -n1 -b | grep "KiB Mem" | awk -F" " '{print $3}') $(top -n1 -b | grep "KiB Mem" | awk -F" " '{print $7}') 
}
#display CPU usage graph
function cpu_graph
{
	echo cpu
}
#display memory usage graph
function mem_graph
{
	echo mem
}
#display process info
function process_info
{
	ps -aux  --sort=-pcpu | head -n 6
}
#display option menu
function show_option
{
	echo "${underline}Options${normal}"
	echo 'h) Show/Hide The Header'
	echo 'c) Show/Hide CPU Usage Graph'
	echo 'm) Show/Hide The Memory Usage Graph'
	echo 'p) Show/Hide The List of The Most CPU-Intensive Processes'
	echo 'o) Show/Hide List of Options'
	echo 'q) Quit'
	echo
}

##main

#variables
header=true
cpuUsage=false
memUsage=false
psInfo=false
showOp=true
underline=$(tput smul)
normal=$(tput sgr0)

#get user's input until user press 'q'. While waiting for user input, modules are display and update as a background process. Everytime user input a character on the keyboard, the background process is killed and a new background process that display modules is created.
while [ "$input" != "q" ]; do
	#display menu base on choice of modules
	display_menu $header $cpuUsage $memUsage $psInfo $showOp&
	displayPID=$!
	#read 1 character from user
	read -n 1 input
	#toggle options
	case "$input" in 
		h) $header && header=false || header=true;;
		c) $cpuUsage && cpuUsage=false || cpuUsage=true;;
		m) $memUsage && memUsage=false || memUsage=true;;
		p) $psInfo && psInfo=false || psInfo=true;;
		o) $showOp && showOp=false || showOp=true;;
		*) ;;
	esac
	#kill the old process
	kill -9 $displayPID 1> /dev/null 2> /dev/null	
done

clear
clear
