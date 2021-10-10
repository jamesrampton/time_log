#!/bin/bash -

function display_time {
  local time=$1
  local hours=$((time/60/60))
  local minutes=$((time/60%60))
  local seconds=$((time%60))
  printf '%02d:%02d:%02d\n' $hours $minutes $seconds
}

title="$*"
SECONDS=0
start_date=$(date "+%F %T")
echo "Started ${title} at ${start_date}"
echo "Press Enter to log this session"
stty -echo -icanon time 0 min 0 # Don't wait when reading input
while true
do
    printf "$(display_time $SECONDS)   \r"
    read key
    if [ $? -eq 0 ] && [ -z "$key" ]
    then
        break
    fi
done
stty sane # Return to normal operation
elapsed_seconds=$SECONDS
echo "Finished ${title} after $(display_time $elapsed_seconds)"
echo "${start_date}: ${title} - $(display_time $elapsed_seconds)" >> ~/tl_sessions.log
