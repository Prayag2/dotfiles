#!/bin/bash

$HOME/.local/bin/launchbar.sh &
ID=$(notify-send "Reloaded polybar!" -p -u low)

killall dunst
notify-send "Reloaded dunst" -r $ID -u low

bspc wm -r &
notify-send "Reloaded WM" -r $ID -u low

pkill -usr1 -x sxhkd &
notify-send "Reloaded sxhkd!" -r $ID -u low
