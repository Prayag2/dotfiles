#!/usr/bin/env sh

# Variables
NAME="Screenshot"
ICON="preferences-desktop-theme"

DIR="$HOME/pictures/screenshots/$(date +%d-%m-%Y)"
ARGS=$1

# Assigning Filename
if [[ $ARGS == *"t"* ]]; then
	FILE="/tmp/ss-$(whoami).png"
else
    mkdir -p $DIR
    let NUM=(1 + $(ls $DIR | wc -l))
    FILE="$DIR/$NUM.png"
fi

# Taking Screenshot
if [[ $ARGS == *"a"* ]]; then
    grim -g "$(slurp)" "$FILE"
else
    grim "$FILE"
fi

if [[ $? -ne 0 ]]; then
    exit 0
fi

# Optimize
if [[ $ARGS == *"o"* ]]; then
    ID=$(notify-send -a "$NAME" -i "$ICON" "Optimising Screenshot" "The screenshot is being optimised. Please wait..." -p -u low)
    optipng "$FILE"
else
    ID=0
fi

# Copy to Clipboard
function copyimage() {
	if [[ $ARGS == *"c"* ]]; then
	    wl-copy < "$FILE"
	fi
}
copyimage

# Notification
OUT=$(notify-send -a "$NAME" -i "$ICON" "Screenshot Taken" "Screenshot saved to $FILE" -r $ID -A "Annotate" -A "Open Image" -A "Delete Image")

# Action
case "$OUT" in
    0)
        drawing "$FILE"
        notify-send -a "$NAME" -i "$ICON" "Screenshot Taken" "Screenshot saved to $FILE" -r $ID
        copyimage
        ;;
    1)
        sxiv "$FILE" ;;
    2)
        rm "$FILE" ;;
esac
