#!/bin/bash
INPUT=$(rofi -dmenu -p "" -theme-str 'entry{placeholder: "Ask ChatGPT..";}')
if [[ -z $INPUT ]]; then
    exit 1
fi

yad --progress --text="Waiting for an answer" --pulsate &

if [[ $? -eq 1 ]]; then
    exit 1
fi

PID=$!

ANSWER=$(~/.local/bin/sgpt "$INPUT" --no-animation --no-spinner)
kill $PID
yad --info --text="$ANSWER"
