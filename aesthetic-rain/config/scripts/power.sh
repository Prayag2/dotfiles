#!/usr/bin/bash

POWEROFF=" Power Off"
LOGOUT="󰍃 Log Out"
SLEEP="󰒲 Sleep"
REBOOT="󰜉 Reboot"

chosen=$(printf "$POWEROFF\n$LOGOUT\n$SLEEP\n$REBOOT" | rofi -dmenu -p "󰐥" -hover-select -me-select-entry '' -me-accept-entry MousePrimary)

powerOff() {
	if [[ "$(cat ~/my-stuff/agenda/tasks.org)" == *"- State \"DONE\"       from \"SHUT\"       [$(date +%Y-%m-%d)"* ]]; then
		runTask "systemctl --no-wall poweroff"
	else
		notify-send "Complete Shutdown Ritual First!"
		exit 1
	fi
}

runTask() {
	if pgrep "pacman"; then
		notify-send "System is busy..."
	else
		sh -c "$1"
	fi
}

case $chosen in
	$POWEROFF) runTask "systemctl --no-wall poweroff" ;;
	$REBOOT) runTask "systemctl --no-wall reboot";;
	$LOGOUT) runTask "pkill -u $(whoami)";;
	$SLEEP) runTask "systemctl suspend";;
	*) exit 0;;
esac
