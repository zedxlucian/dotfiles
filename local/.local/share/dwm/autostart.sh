#!/bin/sh

###---Autostart---###

# Xresources is needed to theme DWM & ST.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/X11/Xresources" ] && xrdb -merge "${XDG_CONFIG_HOME:-$HOME/.config}/X11/Xresources" &

# Notification system
pidof dunst || dunst &

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
pidof xss-lock || xss-lock  -- betterlockscreen -l blur &

# Cursor pointing left
xsetroot -cursor_name left_ptr &

# Program that hides the mouse after 3 seconds of idle
pidof unclutter || unclutter -idle 3 &

# Emacs Daemon
pidof emacs || emacs --daemon &

# Numerical pad on
numlockx on &

# Cloud provider synching software
pidof megasync || megasync &

# Compositor
pidof picom || picom -b &

# Wallpaper
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/profil/bg" ] && xwallpaper --zoom ~/.local/share/profil/bg &

# Statusbar
pidof dwmblocks || dwmblocks &

# Caffeine
pidof caffeine-ng || /usr/bin/caffeine &

# Network Management
pidof nm-applet || nm-applet &

# Cryptomator
pidof cryptomator || cryptomator &
