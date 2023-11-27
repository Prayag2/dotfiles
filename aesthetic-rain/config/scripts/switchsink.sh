#!/bin/bash
# This script cycles through available sinks in Pipewire/Pulseaudio.
# I use this with Polybar. To change the default audio output device,
# I can just middle click on the volume controller.
# Please install "jq" before using this or comment line 23 and 25 (notification)

SINKS=$(pactl list sinks short | awk '{print $2}')
SINKARR=( $SINKS )
LEN=${#SINKARR[@]}
CURRENTSINK=$(pactl get-default-sink)

getNext() {
    if [[ $1 == $(($LEN-1)) ]]; then
        echo 0
    else
        echo $(($1+1))
    fi
}

for ((i=0; i<$LEN; i++)); do
    if [[ "${SINKARR[$i]}" = "$CURRENTSINK" ]]; then
        SINK=${SINKARR[$(getNext $i)]}
        SINKDESC=$(pactl --format=json list sinks | jq ".[] | select(.name == \"$SINK\") | .description")
        pactl set-default-sink "$SINK"
        notify-send -i "audio-speakers-symbolic" "Switched to $SINKDESC"
    fi
done
