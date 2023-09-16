#!/bin/bash

echo "No players found"
playerctl metadata -f '{{status}} {{title}}' -F | while read event; do
    #if [[ $(playerctl metadata artist) = '' ]]; then
        #playerctl metadata -f '{{status}} {{title}}' | sed 's/Paused//; s/Playing//; s/Stopped//'
    #else
    playerctl metadata -f '{{status}} {{title}}' | sed 's/Paused//; s/Playing//; s/Stopped//'
    #fi
done
