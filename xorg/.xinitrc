#!/bin/sh

# Keyboard layout
setxkbmap -layout fr -variant oss

# Loading Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Change keyboard keypress rate
xset r rate 200 30

# Start gnome keyring
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Set QT style to be the same as Gtk
export QT_STYLE_OVERRIDE=gtk2

exec i3 --shmlog-size=26214400
