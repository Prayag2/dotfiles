#!/bin/bash
# I use this script to crop product invoices to print them on a thermal printer.

FILES=$(ls ~/downloads/Flipkart-Labels*.pdf | grep -v "crop")
FILEARR=( $FILES )
OUT=$(for i in $FILES; do echo "${i%.*}-crop.pdf"; done)
OUTARR=( $OUT )
LEN=${#FILEARR[@]}

for ((i = 0; i < $LEN; i++)); do
    # crop pdf
    notify-send "Cropping PDF..."
    pdfcrop --margins "-150 0 -150 -325" "${FILEARR[$i]}" "${OUTARR[$i]}"

    # remove uncropped pdf
    rm "${FILEARR[$i]}"
    
    # open in default program after cropping
    xdg-open "${OUTARR[$i]}"
done
notify-send "Crop successfull"
