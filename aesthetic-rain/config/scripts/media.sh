#!/bin/bash

echo " No Media"
playerctl metadata -f '{{status}} {{title}}' -F 2>/dev/null | while read event; do
    #if [[ $(playerctl metadata artist) = '' ]]; then
        #playerctl metadata -f '{{status}} {{title}}' | sed 's/Paused//; s/Playing//; s/Stopped//'
    #else
    out=$(playerctl metadata -f '{{status}} {{title}}' 2>/dev/null)
    if [[ -z $out ]]; then
	    echo " No Media"
    else
	echo $out | sed 's/Paused//; s/Playing//; s/Stopped//;'
    fi
    #fi
done
