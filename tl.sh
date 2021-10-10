#!/bin/bash -

prog_name=$(basename $0)

function display_time {
    local time=$1
    local hours=$((time/60/60))
    local minutes=$((time/60%60))
    local seconds=$((time%60))
    printf '%02d:%02d:%02d\n' $hours $minutes $seconds
}

sub_help() {
    echo "Usage: $prog_name log [text]"
}

sub_log() {
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
}

subcommand=$1
case $subcommand in
    "" | "-h" | "--help")
        sub_help
        ;;
    *)
        shift
        sub_${subcommand} $@
        if [ $? = 127 ]; then
            echo "Error: '$subcommand' is not a known command." >&2
            echo "       Run '$prog_name --help' for a list of known commands." >&2
            exit 1
        fi
        ;;
esac
