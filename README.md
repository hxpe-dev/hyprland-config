# `hxpe's` hyprland config

**WM:** `hyprland`  
**Terminal:** `kitty`  
**Shell:** `fish`  
**Launcher:** `rofi`  
**Bar:** `waybar`  
**Notifications:** `swaync`  
**Logout:** `wlogout`  

---

### Note to myself
Use the `update_dotfiles.sh` to copy the ~/.config files into the ~/dotfiles folder.
Example usage: 
```
update_dotfiles.sh hypr kitty waybar
```
This command will update the hypr, kitty and waybar config folder into ~/dotfiles.

**Fix wrong time:**  
```
sudo hwclock --hctosys 
sudo timedatectl set-ntp true
```

