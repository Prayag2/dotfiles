#!/usr/bin/env bash

# Variables
new_desktop_name=""
current_monitor="focused"
help_text="Usage: bspdd.sh [options]\
    \nOptions: \
    \n\t-n <name of new desktop>\
    \n\t-m <name of the selected monitor (uses focused monitor by default)>\n"

# Parse Arguments
while getopts "n:m:h" opt; do
    case $opt in
        n)
            new_desktop_name=$OPTARG ;;
        m)
            current_monitor=$OPTARG ;;
        h|\?)
            printf "$help_text"
            exit 1 ;;
    esac
done

# FUNCTIONS
get_total() {
    echo $(bspc query -D -m "$current_monitor" | wc -l)
}
get_occupied() {
    echo $(bspc query -D -d ".occupied" -m "$current_monitor" | wc -l)
}

add_desktop() {
    echo "Adding desktop"
    bspc monitor "$current_monitor" -a "$new_desktop_name"
}

remove_desktops() {
    echo "Removing unoccupied desktops"
    total_desktops=$(get_total)
    occupied_desktops=$(get_occupied)

    while [[ $occupied_desktops -lt $((total_desktops-1)) ]]; do
        bspc desktop "any.!occupied" -r
        total_desktops=$(get_total)
        occupied_desktops=$(get_occupied)
    done
}

manage_desktops(){
    total_desktops=$(get_total)
    occupied_desktops=$(get_occupied)

    if [[ $occupied_desktops -eq $total_desktops ]]; then
        add_desktop
    elif [[ $occupied_desktops -lt $((total_desktops-1)) ]]; then
        remove_desktops
    fi
}

manage_desktops
bspc subscribe node_add node_remove node_transfer | while read -r line;
do
    printf "Total: $total_desktops\nOccupied: $occupied_desktops\n"
    manage_desktops
done
