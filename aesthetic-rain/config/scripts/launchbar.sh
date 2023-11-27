#!/bin/bash

if pgrep -u $(whoami) -f polybar; then
    pkill polybar
    polybar-msg cmd quit
fi

# Launch Polybar
polybar left >/dev/null 2>&1
