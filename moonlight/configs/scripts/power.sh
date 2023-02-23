#!/usr/bin/bash

POWEROFF=" Power Off"
LOGOUT=" Log Out"
SLEEP="⏾ Sleep"
REBOOT=" Reboot"

chosen=$(printf "$POWEROFF\n$LOGOUT\n$SLEEP\n$REBOOT" | rofi -dmenu -p "襤" -hover-select -me-select-entry '' -me-accept-entry MousePrimary)

case $chosen in
	$POWEROFF) systemctl --no-wall poweroff;;
	$REBOOT) systemctl --no-wall reboot;;
	$LOGOUT) pkill -u $(whoami);;
	$SLEEP) systemctl suspend;;
	*) exit 0;;
esac
