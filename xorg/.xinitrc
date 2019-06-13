#!/bin/sh

# Keyboard layout
setxkbmap -layout fr -variant oss

# Loading Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Change keyboard keypress rate
xset r rate 200 30

exec i3
