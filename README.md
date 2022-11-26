<center>

# Nord BSPWM Rice

This is my first time using a window manager instead of a fully fledged desktop environment and I'm loving it so far!

<img src="https://github.com/Prayag2/dotfiles/blob/main/screenshots/ss.jpg" style="width: 100%">
</center>

## Copying The Entire Setup
If you'd like to copy the entire setup, follow these steps:

### Install The Following 
Packages
- rofi (dmenu replacement)
- rofi-greenclip (use rofi as a clipboard manager)
- rofimoji (use rofi to get emojis and symbols)
- polybar (the top panel)
- alacritty (terminal emulator)
- thunar (file manager)
- playerctl (used to control media)
- pamixer (pulseaudio mixer)
- pulseaudio (for audio)
- BSPWM (window manager)
- nitrogen (wallpaper selector)
- lxsession (x session manager?)
- picom (compositor)
- sxhkd (manage keyboard shortcuts)
  
Fonts
- CaskaydiaCove Nerd Font Mono
  
Themes
- Nordic GTK Theme

### Install Konsave
Used to copy config files
- `pip3 install konsave`

### Final Step
Clone the repo
- `git clone https://github.com/prayag2/dotfiles`
- `cd dotfiles`

Import important files using Konsave
- `konsave --import nord.knsv`
- `konsave --apply nord`

Make stuff executable
- `chmod +x ~/.config/bspwm/bspwmrc`
- `chmod +x ~/.config/polybar/scripts/*`
- `chmod +x ~/.config/polybar/launch.sh`
- `chmod +x ~/.config/sxhkd/reload.sh`
- `chmod +x ~/.xinitrc`

Make sure you have installed the font mentioned above.
Now just download and apply the wallpaper using nitrogen and reboot!
