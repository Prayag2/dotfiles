#!/bin/bash
source ~/.zprofile

$HOME/.local/bin/launchbar.sh &
[[ $1 -ne "silent" ]] && ID=$(notify-send "Reloaded polybar!" -p -u low)

killall dunst
[[ $1 -ne "silent" ]] && notify-send "Reloaded dunst" -r $ID -u low

bspc wm -r &
[[ $1 -ne "silent" ]] && notify-send "Reloaded WM" -r $ID -u low

pkill -usr1 -x sxhkd &
[[ $1 -ne "silent" ]] && notify-send "Reloaded sxhkd!" -r $ID -u low
