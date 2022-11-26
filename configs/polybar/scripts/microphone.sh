#!/bin/bash

VOLUME=$(pamixer --source 1 --get-volume-human)

case $VOLUME in
	"muted") echo " 0%" ;;
	*) echo " $VOLUME" ;;
esac
