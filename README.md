<center>
<img src="https://github.com/Prayag2/dotfiles/blob/main/assets/logo.png" style="width: 100%">

---


<details>
<summary>Nord (My First Rice)</summary>
<img src="https://github.com/Prayag2/dotfiles/blob/main/screenshots/ss.jpg" style="width: 100%">
</details>
<details>
<summary>BlurBox (Gruvbox + Blur)</summary>
<img src="https://github.com/Prayag2/dotfiles/blob/main/screenshots/ss-blurbox.png" style="width: 100%">
</details>
<details>
<summary>OneDark</summary>
<img src="https://github.com/Prayag2/dotfiles/blob/main/screenshots/ss-onedark.png" style="width: 100%">
</details>
<details>
<summary>PyWal</summary>
<img src="https://github.com/Prayag2/dotfiles/blob/main/screenshots/ss-pywal.gif" style="width: 100%">
</details>
<details>
<summary>Moonlight and the Roaring Falls</summary>
<img src="https://github.com/Prayag2/dotfiles/blob/main/screenshots/ss-moonlight.png" style="width: 100%">
</details>
</center>

## Details
### Programs
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
  
### Fonts
- CaskaydiaCove Nerd Font Mono
  
### GTK Themes
- **Nord Rice**: Nordic GTK Theme
- **BlurBox**: Breeze GTK with Gruvbox colours
- OneDark: OneDark GTK Theme
- PyWal: FlatColor GTK (Included with WPGTK)
- Moonlight: Linea Nord Color (From WPGTK)

## Copying an Entire Rice

> **NOTE**: Before copying this setup, please note that there are a few scripts like `getWifiStatus.sh` which are highly specific to my setup.

- Each rice folder in this repository has a `.knsv` file inside it (which is actually an archive of all the important files).
- You can install [konsave](https://github.com/prayag2/konsave) and import the whole rice using `konsave --import <path to file>` followed by `konsave --apply <rice name>` to apply it!
- Just make sure to install the programs and fonts listed above! (You'll have to download the wallpaper manually though)
- Run the following commands before rebooting:

For Other Rices
```bash
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/polybar/scripts/*.sh
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/sxhkd/*.sh
```

For PyWal and Moonlight Rice
```bash
chmod +x ~/.config/scripts/*.sh
chmod +x ~/.config/bspwm/bspwmrc
```
