#!/bin/bash

# Variables
NAME="Screenshot"
ICON="preferences-desktop-theme"

DIR="$HOME/Pictures/Screenshots/$(date +%d-%m-%Y)"
ARGS=$1

# Assigning Filename
if [[ $ARGS == *"t"* ]]; then
    FILE="/tmp/ss.png"
else
    mkdir -p $DIR
    let NUM=(1 + $(ls $DIR | wc -l))
    FILE="$DIR/$NUM.png"
fi

# Taking Screenshot
if [[ $ARGS == *"a"* ]]; then
    scrot -s -q 100 --line mode=edge -F "$FILE" -o
else
    scrot -q 100 -F "$FILE" -o
fi

# Optimize
if [[ $ARGS == *"o"* ]]; then
    ID=$(notify-send --app-name="$NAME" --icon="$ICON" "Optimising Screenshot" "The screenshot is being optimised. Please wait..." -p)
    optipng "$FILE"
else
    ID=0
fi

# Copy to Clipboard
if [[ $ARGS == *"c"* ]]; then
    xclip -selection clip -t image/png "$FILE"
fi

# Final Notification
notify-send --app-name="$NAME" --icon="$ICON" "Screenshot Taken" "Screenshot saved to $FILE" -r $ID
