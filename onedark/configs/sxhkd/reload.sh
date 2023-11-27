#!/bin/bash

killall dunst && dunst &
sleep 1
notify-send "Reloaded dunst!"

pkill -usr1 -x polybar &
notify-send "Reloaded Polybar"

bspc wm -r & 
notify-send "Reloaded WM"

pkill -usr1 -x sxhkd &
notify-send "Reloaded sxhkd!"
