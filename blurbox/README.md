## Details
### Programs
- rofi-greenclip (use rofi as a clipboard manager)
- rofimoji (use rofi to get emojis and symbols)
- polybar (the top panel)
- alacritty (terminal emulator)
- thunar (file manager)
- playerctl (used to control media)
- pamixer (pulseaudio mixer)
- pulseaudio in older rices and pipewire in newer ones (for audio)
- BSPWM (window manager)
- nitrogen (wallpaper selector)
- lxsession (x session manager?)
- picom (compositor)
- sxhkd (manage keyboard shortcuts)
  
### Fonts
- CaskaydiaCove Nerd Font Mono
  
### GTK Themes
Breeze GTK with Gruvbox colours

## Copying an Entire Rice

> **NOTE**: Before copying this setup, please note that there are a few scripts like `getWifiStatus.sh` which are highly specific to my setup.
- Clone the repo using `cd ~/Downloads && git clone https://github.com/prayag2/dotfiles`
- Each rice folder in this repository has a `.knsv` file inside it (which is actually an archive of all the important files).
- Install [konsave](https://github.com/prayag2/konsave), the programs, and the fonts listed above.
- Import the preferred rice using `konsave --import <path to knsv file>` 
- Apply the rice using `konsave --apply <rice name>`
- Run the following commands and reboot:
```bash
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/polybar/scripts/*.sh
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/sxhkd/*.sh
```
Please note that these configs might crash due to them being outdated.