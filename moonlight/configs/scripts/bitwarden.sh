#!/bin/sh

if [[ ! $(rbw unlocked) ]]; then
    rbw unlock
fi

OPTION=$(printf " Get Passwords\n痢 Sync Bitwarden\n Lock Database" | rofi -dmenu -p "ﳳ" -i)


getPass() {
    OUTPUT=$(rbw get "$(rbw list | rofi -dmenu -p "ﳳ" -i)" --full)
    if [[ -z $OUTPUT ]]; then
        exit 1
    fi
    echo $OUTPUT | sed "s/\w*: /\n/g" | rofi -dmenu -P  | xclip -selection clip
}


case $OPTION in
    " Get Passwords")
        getPass
        ;;
    "痢 Sync Bitwarden")
        notify-send "Syncing Bitwarden Database..." -u low
        rbw sync
        notify-send "Sync Complete"
        ;;
    " Lock Database")
        rbw lock
        notify-send "Locked successfully."
esac
