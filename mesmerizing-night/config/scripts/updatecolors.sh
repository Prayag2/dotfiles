#!/bin/bash
# DEPENDS ON yadpas.sh
export SUDO_ASKPASS=~/.local/bin/yadpass.sh
PROFILE="$HOME/.zprofile"

/usr/bin/wpg -a "$1"
/usr/bin/wpg -s "$1"
timeout 10 wal -i "$1" -e

if [[ $? -ne 0 ]]; then
    notify-send "Please choose a different wallpaper."
    exit 1
fi

# Change colour based on the darkness of an image
brightness=$(magick identify -format "%[fx:int(mean*100)]" -crop 100%x50%+0+0 "$1")
if [[ $brightness -le 60 ]]; then
    echo "The current wallpaper is DARK at the top"
    sed -i "s/#99000000/#33ffffff/" "$PROFILE"
else
    echo "The current wallpaper is LIGHT at the top"
    sed -i "s/#33ffffff/#99000000/" "$PROFILE"
fi

~/.local/bin/reload.sh

# SDDM THEME
if yad --text="Would you like to apply this wallpaper to the lockscreen?"; then
    . "${HOME}/.cache/wal/colors.sh"
    WALL="/usr/share/sddm/themes/sugar-candy/Backgrounds/Wall.png"
    CONF="/usr/share/sddm/themes/sugar-candy/theme.conf"

    BG="BackgroundColor=\"$color0\""
    AC="AccentColor=\"$color3\""
    
    # Updating colours and wallpaper
    sudo -A sed -i "s/BackgroundColor='.\+'/$BG/" $CONF
    sudo -A sed -i "s/AccentColor='.\+'/$AC/" $CONF
    sudo -A magick convert "$1" "$WALL"
else
    exit 0
fi
