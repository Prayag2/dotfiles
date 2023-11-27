#!/bin/bash
# run calc, copy result on pressing "Ctrl+Return", run this again using they keyboard shortcut
rofi -modi calc -show calc -calc-command 'echo "{result}" | xclip -selection clipboard && sleep 0.3 && xdotool key Super+equal'
