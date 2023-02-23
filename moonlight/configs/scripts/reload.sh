#!/bin/bash

killall dunst
ID=$(notify-send "Reloaded dunst!" -p -u low)

bspc wm -r &
notify-send "Reloaded WM" -r $ID -u low

pkill -usr1 -x sxhkd &
notify-send "Reloaded sxhkd!" -r $ID -u low --expire-time=1000
