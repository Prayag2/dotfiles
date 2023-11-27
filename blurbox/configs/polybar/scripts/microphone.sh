#!/bin/bash

status() {
	VOLUME=$(pamixer --source 1 --get-volume-human)
	case $VOLUME in
		"muted") echo " $(pamixer --source 1 --get-volume)%" ;;
		*) echo " $VOLUME" ;;
	esac
}

listen() {
	status

	LANG=EN; pactl subscribe | while read event; do
		if echo "$event" | grep -q "source"; then
			status
		fi
	done
}

listen
