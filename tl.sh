#!/bin/bash -
title="$*"
SECONDS=0
start_date=$(date "+%F %T")
echo "${title} started at ${start_date}"
read -r -p"Press enter to finish this time session. "
elapsedseconds=$SECONDS
# TODO Parse this into something meaningful
echo "Finished ${title} after ${elapsedseconds} seconds"
echo "${start_date}: ${title} - ${elapsedseconds} seconds" >> ~/timelog.txt

