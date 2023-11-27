#/usr/bin/bash

USEPLAYERCTL=$1
if [[ $USEPLAYERCTL -eq 1 ]]
then
    FLOAT_VOL=$(playerctl volume)
    VOL=$(echo "$FLOAT_VOL * 100" | bc | awk '{printf"%.0f\n",$1}')
else
    VOL="$(pamixer --get-volume)"
fi

notify-send --icon="audio-volume-high-symbolic" "$VOL%" -r 1 -u low -t 500
