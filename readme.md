# Mabylife's Hyprland Dotfiles

## Credits

### [@binnewbs](https://github.com/binnewbs)

Big thanks to Been, I was able to learn a lot from his dotfiles and scripts. In fact, without his YouTube showcase video, I would never decide to swtich to Linux and Hyprland.

My dotfiles are **based on his**, but I have modified and customized them to fit my own preferences and needs.

### [@JaKooLit](https://github.com/JaKooLit)

GOAT, No need to explain

## Dotfiles content

### Applications contained

- Hyprland/Hypridle/Hyprlock
- Cava
- Fastfetch
- Kitty Terminal
- Matugen(with swww)
  - waybar, kitty, hyprland, rofi, cava, vesktop, btop, asusctl keyboard lighting, sddm
- Rofi
- SDDM
- SwayNC
- Waybar
- Wlogout
- Yazi

---

- Wallpapers collection mostly from artist [@mmAir](https://mmair.artstation.com/)

### SDDM Theme Installation

**When moving files for SDDM, do not use symlinks, it will not work.**

1. First, put `/sddm/simple-sddm` folder to `/usr/share/sddm/themes/`

2. Then, edit the sddm config file at `/etc/sddm.conf.d/theme.conf.user`

   ```
   sudo nano /etc/sddm.conf.d/theme.conf.user
   ```

3. Add the following lines in the file:

   ```
   [Theme]
   Current=simple-sddm
   ```
