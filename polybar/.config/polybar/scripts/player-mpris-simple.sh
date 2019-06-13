#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    status_icon=""
elif [ "$player_status" = "Paused" ]; then
    status_icon=""
fi

artist="$(playerctl metadata artist 2> /dev/null)"
title="$(playerctl metadata title 2> /dev/null)"

echo "$status_icon $artist - $title"
