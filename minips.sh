#!/bin/bash
#display all processes' name, id, and current state
# Author: Zeal Yim
cd /proc
for i in $(ls | grep "[0-9]*[0-9]"); do
  cd $i 2> /dev/null
  name=$(grep -e "^Name:" status 2> /dev/null)
  pid=$(grep -e  "^Pid:" status 2> /dev/null)
  stat=$(grep -e "^State:" status 2> /dev/null)
  echo $name $pid $stat
  cd /proc
done
exit
