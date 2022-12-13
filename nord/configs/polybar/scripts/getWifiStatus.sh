#!/usr/bin/zsh
LC_ALL="en_US.UTF-8"
if [ $(nmcli -p | grep wlp21s0f0u5 | awk 'NR==1 { print $2}') = 'connected' ]; then echo "直"; else echo "睊"; fi
