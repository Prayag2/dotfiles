#!/usr/bin/env bash

if ! [[ -z "$1" ]]; then
	echo "$1"
    wall="$1"
elif [[ -e "$HOME/.config/videoWall" ]]; then
    wall="$(cat $HOME/.config/videoWall)"
else
    exit 1
fi
killall xwinwrap > /dev/null 2>&1 
xwinwrap -g 1920x1080+0+0 -ovr -ni -- mpv --fullscreen --no-stop-screensaver --loop --no-audio --no-border --no-osc --no-osd-bar --no-input-default-bindings -wid WID "$wall" > /dev/null 2>&1 & 
