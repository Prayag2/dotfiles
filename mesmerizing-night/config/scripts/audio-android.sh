#!/usr/bin/env sh

IP="$(ifconfig | grep inet | grep broadcast | awk 'NR==1{{print $2}}')"

if [[ "$(pactl list)" == *"module-simple-protocol-tcp"* ]]; then
    pactl unload-module module-simple-protocol-tcp
    echo "STOPPED"
else
    pactl load-module module-simple-protocol-tcp rate=48000 format=s16le source="alsa_output.pci-0000_38_00.6.analog-stereo.monitor" record=true port=4656
    notify-send "Audio Share Started" "Sending audio to $IP on port 4656\nSample Rate: 48000"
    echo "STARTED"
fi
