#!/bin/bash
SPAM_FILE="/tmp/spam"

if [[ -e $SPAM_FILE ]]; then
    notify-send "Spam Ended"
    rm $SPAM_FILE
    killall "spam.sh"
    exit 0
else
    notify-send "Spam Started"
    touch $SPAM_FILE
    while [[ 1 ]]; do xdotool click 1 && sleep 0.01; done
fi
