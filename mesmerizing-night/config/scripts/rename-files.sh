#!/bin/bash
# This script renames all the files and folders in specified directory
# to have small letters only. It also replaces " " with "-".
# I have added this as a context menu entry in Thunar to save time.

parent="$1"
for dir in "$parent"/*; do
    # Get the directory name without the trailing slash
    dirname=$(basename "$dir")

    # Convert the directory name to lowercase and replace spaces with hyphens
    newname=$(echo "$dirname" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

    # Rename the directory
    mv "$dir" "$parent/$newname"
done
