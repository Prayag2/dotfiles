#!/bin/bash

case "$1" in
    --toggle)
        dunstctl set-paused toggle
        ;;
    *)
        if [ "$(dunstctl is-paused)" = "true" ]; then
            echo ""
        else
            echo ""
        fi
        ;;
esac
