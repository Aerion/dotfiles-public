#!/bin/bash

pkill -u "$USER" -USR1 dunst

i3lock-fancy -t '' -p -n

pkill -u "$USER" -USR2 dunst
