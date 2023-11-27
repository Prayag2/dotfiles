#!/bin/bash

if pgrep -u $(whoami) -f polybar; then
    # Terminate already running bar instances
    killall -q polybar

    # If all your bars have ipc enabled, you can also use
    polybar-msg cmd quit

    # kill all processes related to polybar (including scripts)
    #kill -9 $(pgrep -f 'polybar') >/dev/null 2>&1
    killall polybar >/dev/null 2>&1
fi

# Launch Polybar
polybar left 2>&1 | tee -a /tmp/polybar.log & disown
