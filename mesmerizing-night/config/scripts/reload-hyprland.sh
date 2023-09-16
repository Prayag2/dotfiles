#!/usr/bin/env sh

# Waybar
rm /tmp/execpkgs
killall waybar; waybar &

# Emacs
# killall -KILL emacs; emacs --daemon &

# Dunst
killall dunst

# Pywal
wal -R

# Hyprland
hyprctl reload
