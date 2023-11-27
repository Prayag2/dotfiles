#!/bin/bash

status() {
	VOLUME=$(pamixer --default-source --get-volume-human)
	case $VOLUME in
		"muted") echo "%{T3}%{T3} %{T1}$(pamixer --default-source --get-volume)%%{T1}" ;;
		*) echo "%{T3}%{T3} %{T1}${VOLUME}%{T1}" ;;
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
