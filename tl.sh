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
echo "${title} started at ${start_date}"
read -r -p"Press enter to finish this time session. "
elapsedseconds=$SECONDS
echo "Finished ${title} after $(displaytime $elapsedseconds)"
echo "${start_date}: ${title} - $(displaytime $elapsedseconds)" >> ~/timelog.txt
