#!/bin/bash

status() {
	VOLUME=$(pamixer --default-source --get-volume-human)
	case $VOLUME in
		"muted") echo " $(pamixer --default-source --get-volume)%" ;;
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
