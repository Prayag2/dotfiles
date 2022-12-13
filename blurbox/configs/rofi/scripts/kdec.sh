#!/bin/bash

# menu
CHOSEN=$(printf " Pair a Device\n Ring a Device\n See Device Notifications" | rofi -dmenu -p "")

# list devices
list_devices() {
	DEVICES=$(kdeconnect-cli -l --name-only)
	echo $DEVICES
	#rofi -dmenu -p ""
}

list_available() {
	kdeconnect-cli -a --name-only | rofi -dmenu -p ""
}

pair_device() {
	DEVICE=$(list_devices)
	notify-send "Connecting to $DEVICE.."
	kdeconnect-cli --pair --name "$DEVICE"
	notify-send "Connection Successful!"
}

ring_device() {
	DEVICE=$(list_available)

	if [ $? -ne 0 ]; then
		notify-send "Couldn't Connect!";
		exit 1
	fi

	notify-send "Ringing $DEVICE"
	kdeconnect-cli --ring --name "$DEVICE"
}

get_notifications() {
	DEVICE=$(list_available)
	notify-send "Fetching notifications..."
}

case $CHOSEN in
	" Pair a Device") pair_device ;;
	" Ring a Device") ring_device ;;
esac
