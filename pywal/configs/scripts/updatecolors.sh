#!/bin/bash
~/.local/bin/wpg -a "$1"
~/.local/bin/wpg -s "$1"
wal -i "$1"
~/.local/bin/reload.sh
pywal-discord -t default
