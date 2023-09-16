#!/usr/bin/env sh

# DEPENDS ON yadpas.sh
export SUDO_ASKPASS=~/.local/bin/yadpass.sh

if [[ "$1" = "r" ]]; then
    img="$2/$(ls "$2" | shuf -n 1)"
    echo "$img"
else
    img="$1"
fi

swww img "$img" -t any --transition-fps 60
sleep 2
/usr/bin/wpg -a "$img"
/usr/bin/wpg -s "$img"
timeout 10 wal -i "$img" -e

if [[ $? -ne 0 ]]; then
    notify-send "Please choose a different wallpaper."
    exit 1
fi

~/.local/bin/reload-hyprland.sh

# SDDM THEME
if yad --text="Would you like to apply this wallpaper to the lockscreen?"; then
    . "${HOME}/.cache/wal/colors.sh"
    WALL="/usr/share/sddm/themes/sugar-candy/Backgrounds/Wall.png"
    CONF="/usr/share/sddm/themes/sugar-candy/theme.conf"

    BG="BackgroundColor=\"$color0\""
    AC="AccentColor=\"$color3\""

    # Updating colours and wallpaper
    sudo -A sed -i "s/BackgroundColor=\".\+\"/$BG/" $CONF
    sudo -A sed -i "s/AccentColor=\".\+\"/$AC/" $CONF
    sudo -A magick convert "$img" "$WALL"
    notify-send "Updated lockscreen successfully"
else
    exit 0
fi
