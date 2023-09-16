#!/usr/bin/env sh

name=$(rofi -dmenu -p "卵" -theme-str 'entry{placeholder: "Enter name of the pokemon";}' | sed "s/\b\([a-z]\)/\u\1/g; s/ /_/g")
url="https://wiki.pokemonrevolution.net/index.php?title=$name&action=edit"
tmp_file="/tmp/pokemon-tmp.html"

if [[ -z $name ]]; then
    exit 0
fi

notify() {
    notify-send -i "/home/prayag/pictures/other/pokemon-icon.png" "$1" "$2" -t 20000
}

curl -s "$url" > $tmp_file
data=$(cat $tmp_file | pup "textarea#wpTextbox1 text{}")
weaknesses=$(echo $data | grep -oP "(?<=Weaknesses=)[^|}]+")
neutralities=$(echo $data | grep -oP "(?<=Neutralities=)[^|}]+")
resistances=$(echo $data | grep -oP "(?<=Resistances=)[^|}]+")
immunities=$(echo $data | grep -oP "(?<=Immunities=)[^|}]+")

notify "Weaknesses" "$(echo $weaknesses | sed 's/, /,/g; s/ /\n---\n/g; s/,/, /g')"
notify "Neutral To" "$(echo $neutralities | sed 's/, /,/g; s/ /\n---\n/g; s/,/, /g')"

if [[ -z $resistances ]]; then
    resistances="None"
fi
notify "Resistant To" "$(echo $resistances | sed 's/, /,/g; s/ /\n---\n/g; s/,/, /g')"

if [[ -z $immunities ]]; then
    immunities="None"
fi
notify "Immune To" "$(echo $immunities | sed 's/, /,/g; s/ /\n---\n/g; s/,/, /g')"

rm $tmp_file
