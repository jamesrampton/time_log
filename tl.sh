#!/bin/bash -

function displaytime {
  local T=$1
  local H=$((T/60/60))
  local M=$((T/60%60))
  local S=$((T%60))
  printf '%02d:%02d:%02d\n' $H $M $S
}

title="$*"
SECONDS=0
start_date=$(date "+%F %T")
echo "Started ${title} at ${start_date}"
echo "Press Enter to log this session"
stty -echo -icanon time 0 min 0 # Don't wait when reading input
while true
do
    printf "$(displaytime $SECONDS)   \r"
    read key
    if [ $? -eq 0 ] && [ -z "$key" ]
    then
        break
    fi
done
stty sane # Return to normal operation
elapsedseconds=$SECONDS
echo "Finished ${title} after $(displaytime $elapsedseconds)"
echo "${start_date}: ${title} - $(displaytime $elapsedseconds)" >> ~/timelog.txt
