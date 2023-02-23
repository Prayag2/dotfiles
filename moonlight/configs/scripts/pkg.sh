#!/bin/sh
echo "-/-"

# Checking network connection
ID=$(notify-send --icon="system-software-update" "Checking network..." -p --urgency=low)
ping -c 1 google.com 2>/dev/null
if [[ ! $? -eq 0 ]]; then
    notify-send --icon="system-software-update" "Network Error" -r $ID --urgency=low --expire-time=1000
    exit 0
fi

notify-send --icon="system-software-update" "Checking for updates..." -r $ID --urgency=low
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
    notify-send --icon="security-high" "You are up-to-date :)" -r $ID --expire-time=1000
fi
