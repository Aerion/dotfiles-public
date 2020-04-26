#!/usr/bin/env bash

pkill polybar

if type "xrandr"; then
    for m in $(xrandr --listactivemonitors | tail -n +2 | grep -oE '\S+$'); do
        MONITOR=$m polybar --reload mybar &
    done
else
    polybar --reload mybar &
fi
