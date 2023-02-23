#!/bin/bash
PASS=$(yad --entry --text="Enter Password")

/usr/bin/wpg -a "$1"
/usr/bin/wpg -s "$1"
wal -i "$1" -e
~/.local/bin/reload.sh
pywal-discord -t default

# sudo
root(){
    echo $PASS | sudo -S sh -c "$*"
}

# SDDM THEMES
. "${HOME}/.cache/wal/colors.sh"
WALL="/usr/share/sddm/themes/sugar-candy/Backgrounds/Wall.png"
CONF="/usr/share/sddm/themes/sugar-candy/theme.conf"

BG="BackgroundColor=\"$color0\""
AC="AccentColor=\"$color2\""

# Updating colours and wallpaper
root sed -i "s/BackgroundColor='.\+'/$BG/" $CONF
root sed -i "s/AccentColor='.\+'/$AC/" $CONF
root magick convert "$1" "$WALL"
