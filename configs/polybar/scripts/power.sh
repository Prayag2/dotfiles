#!/usr/bin/bash
chosen=$(printf " Power Off\n Log Out\n⏾ Sleep\n Reboot" | rofi -dmenu -p "")

case $chosen in
	" Power Off") systemctl poweroff;;
	" Reboot") systemctl reboot;;
	" Log Out") pkill -u prayag;;
	"⏾ Sleep") systemctl suspend;;
	*) exit 0;;
esac
