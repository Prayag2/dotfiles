#!/bin/sh
if ! updates_arch="$(checkupdates | wc -l)"; then
    updates_arch=0
fi

if ! updates_aur="$(yay -Qum 2>/dev/null | wc -l)"; then
    updates_aur=0
fi

updates="$((updates_arch + updates_aur))"

if [ "$updates" -gt 0 ]; then
    echo "$updates_arch/$updates_aur"
else
    echo 0
fi
