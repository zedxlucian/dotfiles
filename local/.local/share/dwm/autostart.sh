#!/usr/bin/env bash
set -euo pipefail

###---Autostart---###

# Xresources is needed to theme DWM & ST.
[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/X11/Xresources" ]] && xrdb -merge "${XDG_CONFIG_HOME:-$HOME/.config}/X11/Xresources" &

# Notification system
dunst &

# Keyboard Layout
# 1. Set default keyboard leyout
# 2. Set both caps lock keys to toggle caps behavior
# 3. Make caps lock act as Ctrl when pressed with other key
setxkbmap -layout fr \
          -option grp:lctrl_lwin_toggle \
          -option shift:both_capslock \
          -option caps:ctrl_modifier &

# Key Repeat Delay And Interval
xset r rate 300 50 &

# Automatic Screen-Lock
xss-lock  -- betterlockscreen -l blur &

# Cursor pointing left
xsetroot -cursor_name left_ptr &

# Program that hides the mouse after 3 seconds of idle
unclutter -idle 3 &

# Emacs Daemon
emacs --daemon &

# Numerical pad on
numlockx on &

# Cloud provider synching software
megasync &

# Compositor
picom -b &

# Nvim server
NVIM_LISTEN_ADRESS=/tmp/nvimsocket nvim &

# Wallpaper
[[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/profil/bg" ]] && xwallpaper --zoom ~/.local/share/profil/bg &

# Statusbar
dwmblocks &

# SSH Agent
eval $(ssh-agent) &

# Caffeine
/usr/bin/caffeine &
