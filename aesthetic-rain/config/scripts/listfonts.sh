#!/bin/bash
fc-list -f "%{family}\n" | sort | uniq | rofi -dmenu -p "" -theme-str "entry {placeholder:\"Select a font..\";}" -i | xclip -sel c
