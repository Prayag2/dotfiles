#!/bin/bash

killall dunst && dunst &
sleep 1
ID=$(notify-send "Reloaded dunst!" -p)

bspc wm -r & 
notify-send "Reloaded WM" -r $ID

pkill -usr1 -x sxhkd &
notify-send "Reloaded sxhkd!" -r $ID
