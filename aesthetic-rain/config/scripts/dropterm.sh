#!/bin/bash

# VARIABLES
readonly className=$1 # Class of the window. Use `xprop WM_CLASS` to get it
readonly programName=$2 # Command to run
readonly winDimensions=$3 # Dimensions in the format "WIDTHxHEIGHT+XOFFSET+YOFFSET"
readonly winIDFile="/tmp/dropwid" # File that stores window ID
readonly waitFile="/tmp/dropwait" # File that indicates that a window is already being opened
readonly hidFile="/tmp/drophid" # File that shows whether the window is hidden or not

function toggleWin() {
	local winID=$1
	if bspc query -N -n any.hidden | grep -q "$winID"; then
	#if [[ -e $hidFile ]]
		# If the window was found in the hidden list, unhide and focus it
		#xdotool windowmap "$winID"
		bspc node "$winID" -d focused --flag hidden=off
		#bspc node "$winID" -d focused
		bspc node -f "$winID"
		#rm "$hidFile"
	else
		# Hide the window if not found
		bspc node "$winID" --flag hidden=on
		#xdotool windowunmap "$winID"
	fi
}

function newWin() {
	# Create the waiting file
	touch "$waitFile"

	# Add a "oneshot" bspwm rule, launch the program, wait for it to launch, grab its ID and store it
	bspc rule -a "$className" state=floating desktop=focused follow=on -o rectangle="$winDimensions"
	sh -c "$programName" >/dev/null 2>&1 & sleep 1
	local winID=$(bspc query -N -n newest.window)
	echo "$winID" > "$winIDFile"

	# Remove the waiting file
	rm "$waitFile"
}

if [[ -e "$waitFile" ]]; then
	# If the waiting file (waitFile) was found, exit the program.
	# This is done so that if the user runs this more than once in less than a second, 
	# it won't launch multiple instances of the program when creating a new window.
	# If there's a better way to handle this, please contribute!
	exit 1
fi

if [[ -e "$winIDFile" ]]; then
	# Get the winID, check if it still exists, and toggle its visibility
	winID=$(cat "$winIDFile")
	if ! bspc query -N | grep -q "$winID"; then
		rm "$winIDFile"
		newWin
	else
		toggleWin "$winID"
	fi
else
	# Create a new window if it doesn't exist
	newWin
fi
