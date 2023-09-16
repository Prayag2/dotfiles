#!/usr/bin/env sh

historyfile="/tmp/clipd-file"
imagedir="/tmp/clipd-images"

if [[ "$1" = "show" ]]; then
    cat "$historyfile" | sed ':a;N;$!ba;s/\n/\\n/g; s/\*\*\^\*\*/\n/g' | rofi -dmenu -p 
    exit 0
fi

rm "$historyfile" || echo skipping
rm -rf "$imagedir" || echo skipping
mkdir "$imagedir" || echo skipping

wl-paste -w echo 'copied' | while read -r event; do
    datatype=$(wl-paste -l)

    if [[ $datatype = *"image"* ]]; then
        imgpath="$imagedir/$(ls $imagedir | wc -l).png"
        wl-paste >> "$imgpath"
        echo "$imgpath" >> "$historyfile"
        echo "**^**" >> "$historyfile"

    elif [[ $datatype = *"text"* ]]; then
        echo "Copied text!"
        wl-paste >> "$historyfile"
        echo "**^**" >> "$historyfile"

    else
        echo "Unsupported..."

    fi
done
