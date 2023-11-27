#!/bin/sh

if [[ ! $(rbw unlocked) ]]; then
    rbw unlock
fi

OPTION=$(printf "󰟵 Get Passwords\n󱤛 Sync Bitwarden\n󰌾 Lock Database" | rofi -dmenu -p "" -i)


getPass() {
    OUTPUT=$(rbw get "$(rbw list | rofi -dmenu -p "" -i)" --full)
    if [[ -z $OUTPUT ]]; then
        exit 1
    fi

    PASS=$(printf "$OUTPUT" | rofi -dmenu -P  | sed "s/\S*: //g" | tr -d "\n")
    if [[ $XDG_SESSION_TYPE = "wayland" ]]; then
        printf "$PASS" | wl-copy
        wtype "$PASS"
    else
        printf "$PASS" | xclip -sel c
        xdotool type "$PASS"
    fi
}


case $OPTION in
    "󰟵 Get Passwords")
        getPass
        ;;
    "󱤛 Sync Bitwarden")
        notify-send "Syncing Bitwarden Database..." -u low
        rbw sync
        notify-send "Sync Complete"
        ;;
    "󰌾 Lock Database")
        rbw lock
        notify-send "Locked successfully."
esac
