#!/bin/bash
ORIGINAL="# Host addresses
127.0.0.1   localhost
::1		    localhost
127.0.1.1	prayag-linux.localdomain	localhost

# Genshin Impact Telemetry
0.0.0.0 sg-public-data-api.hoyoverse.com
0.0.0.0 log-upload-os.hoyoverse.com"

BLOCKED="# Host addresses
127.0.0.1   localhost
::1		    localhost
127.0.1.1	prayag-linux.localdomain	localhost

# Genshin Impact Telemetry
0.0.0.0 sg-public-data-api.hoyoverse.com
0.0.0.0 log-upload-os.hoyoverse.com

# BLOCKED
0.0.0.0  instagram.com
0.0.0.0  www.instagram.com
0.0.0.0  reddit.com
0.0.0.0  www.reddit.com
0.0.0.0  old.reddit.com
0.0.0.0  github.com
0.0.0.0  www.github.com
0.0.0.0  gists.github.com
0.0.0.0  monkeytype.com
0.0.0.0  www.monkeytype.com
0.0.0.0  gmail.com
0.0.0.0  www.gmail.com
0.0.0.0  mail.gmail.com
0.0.0.0  stackoverflow.com
0.0.0.0  www.stackoverflow.com
0.0.0.0  forum.manjaro.org
0.0.0.0  manjaro.org
0.0.0.0  unix.stackexchange.com
0.0.0.0  stackexchange.com
0.0.0.0  askubuntu.com
0.0.0.0  www.askubuntu.com"

FILE=/etc/hosts

if [[ $1 = "block" ]]; then
    if [[ "$(cat $FILE)" = "$BLOCKED" ]]; then
        echo "Skipping..."
        exit 0
    else
        CMD="echo '$BLOCKED' > '$FILE'"
        echo "1010" | sudo -S sh -c "$CMD" &
    fi
else
    if [[ "$(cat $FILE)" = "$ORIGINAL" ]]; then
        echo "Skipping..."
        exit 0
    else
        CMD="echo '$ORIGINAL' > '$FILE'"
        echo "1010" | sudo -S sh -c "$CMD" &
    fi
fi
