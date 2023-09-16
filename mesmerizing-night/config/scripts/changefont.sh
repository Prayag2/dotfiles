#!/bin/env bash
# This script will change my font across multiple programs.

FONT=$(fc-list -f "%{family}\n"\
    | sort\
    | uniq\
    | rofi -dmenu -p ""\
    -theme-str "entry {placeholder:\"Select a font..\";}" -i)

replaceString() {
    fileName="$1"
    toReplace="$2"

    sed -i "s/$2/$FONT/g" "$1"
}

# GTK Apps
gsettings set org.gnome.desktop.interface "$FONT"
