#!/bin/bash
# Dependencies
# - xwinwrap (for videos) (not in AUR)
# - wpgtk
# - python-pywal
# - sddm-sugar-candy-git
# - l5p-keyboard-rgb-bin (optional) (Lenovo Legion/Ideapad Gaming)
# - yad (from yadpass.sh)
# - libnotify

export SUDO_ASKPASS=~/.local/bin/yadpass.sh
totalSteps=5
videoWall="$HOME/.config/videoWall"
wallFolder="$HOME/.local/share/wallpapers"
wallLocation="$wallFolder/wall.png"

getrgb() {
    local hex_color="$1"
    hex_color="${hex_color#"#"}"

    if ! [[ $hex_color =~ ^[0-9a-fA-F]{6}$ ]]; then
        echo "Invalid hex color code: $hex_color"
        return 1
    fi

    red=$((16#${hex_color:0:2}))
    green=$((16#${hex_color:2:2}))
    blue=$((16#${hex_color:4:2}))

    echo "$red,$green,$blue"
}

notify() {
    local step="$1"
    local message="$2"
    local timeout="$3"

    if [[ -z "$4" ]]; then
	ID=$(notify-send "[$step/$totalSteps] $message" -p -u low -t 99999)
	return "$ID"
    else
	notify-send "[$step/$totalSteps] $message" -r "$4" -u low -t 99999
    fi
}

update_keyboard_backlight() {
    if [[ -e "/usr/bin/legion-kb-rgb" ]]; then
        sudo -A legion-kb-rgb set -e Static -c "$(getrgb $color1),$(getrgb $color3),$(getrgb $color1),$(getrgb $color3)" -b High
    fi
}

update_sddm_theme() {
    wall="/usr/share/sddm/themes/sugar-candy/Backgrounds/Wall.png"
    theme_conf="/usr/share/sddm/themes/sugar-candy/theme.conf"
    background_color="BackgroundColor=\"$color0\""
    accent_color="AccentColor=\"$color3\""

    # Updating colors and wallpaper in SDDM theme config
    sudo -A sed -i "s/BackgroundColor='.\+'/$background_color/" $theme_conf
    sudo -A sed -i "s/AccentColor='.\+'/$accent_color/" $theme_conf
    sudo -A magick convert "$1" "$wall"
}

main() {
    extension="${1##*.}"
    firstArg=$(readlink -f "$1")
    mkdir -p "$wallFolder"

    if [[ $extension == "mkv" || $extension == "mp4" ]]; then
	echo "$firstArg" > $videoWall
	wall=$wallLocation
	ffmpeg -y -i "$firstArg" -vframes 1 "$wall" >/dev/null 2>&1
    else
	[[ -e $videoWall ]] && rm $videoWall
	pgrep -f "xwinwrap" && killall xwinwrap
	magick convert "$firstArg" "$wallLocation"
	wall="$wallLocation"
    fi

    ID=$(notify 0 "Applying wallpaper using WPG" 99999)
    rm -rf "$HOME/.cache/wal"
    rm -rf "$HOME/.config/wpg"
    /usr/bin/wpg -a "$wall" >/dev/null
    /usr/bin/wpg -s "$wall" >/dev/null

    if [[ $? -ne 0 ]]; then
        notify-send "Please choose a different wallpaper."
        exit 1
    fi

    notify 1 "Reloading polybar, dunst and bspwm" 99999 "$ID"
    ~/.local/bin/reload.sh "silent"

    notify 2 "Updating betterlockscreen" 99999 "$ID"
    betterlockscreen -u "$wall"

    source "$HOME/.cache/wal/colors.sh"
    notify 3 "Changing keyboard colours" 99999 "$ID"
    update_keyboard_backlight

    notify 4 "Updating SDDM" 99999 "$ID"
    update_sddm_theme "$wall"

    ~/.config/scripts/video-wall.sh
    notify 5 "Done" 5 "$ID"
}

main "$1"
