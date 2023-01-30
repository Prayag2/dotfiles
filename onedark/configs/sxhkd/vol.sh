#!/bin/bash
notify-send --icon="preferences-desktop-sound" "Volume: $(pamixer --get-volume)%"
