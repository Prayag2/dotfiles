#!/bin/sh

# Checking network connection
#ping -c 1 google.com
#if [[ ! $? -eq 0 ]]; then
#    notify-send --icon="network-offline" "Unable to check for updates!"
#    exit 1
#fi

ID=$(notify-send --icon="system-software-update" "Checking for updates..." -p)
if ! updates_arch="$(checkupdates | wc -l)"; then
    updates_arch=0
fi

if ! updates_aur="$(yay -Qum 2>/dev/null | wc -l)"; then
    updates_aur=0
fi

updates="$((updates_arch + updates_aur))"

if [ "$updates" -gt 0 ]; then
    echo "$updates_arch/$updates_aur"
    notify-send --icon="security-low" "$updates update(s) available! Please update." -r $ID
else
    echo 0
    notify-send --icon="security-high" "You are up-to-date :)" -r $ID
fi
