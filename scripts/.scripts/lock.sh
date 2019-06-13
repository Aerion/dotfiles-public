#!/bin/bash

# https://www.flaticon.com/free-icon/lock_891399
icon="$HOME/Pictures/lock.png"
tmpbg='/tmp/screen.png'

maim \
    | convert -scale 5% -scale 2000% fd:0 fd:1 \
    | convert fd:0 "$icon" -gravity center -composite -matte "$tmpbg"

pkill -u "$USER" -USR1 dunst

letterEnteredColor=d23c3dff
letterRemovedColor=d23c3dff
passwordCorrect=00000000
passwordIncorrect=d23c3dff
background=000000aa
foreground=000000ff
i3lock \
    -t -i "$tmpbg" \
    --timepos="x+110:h-70" \
    --datepos="x+135:h-45" \
    --clock --datestr "$USER" \
    --insidecolor=$background --ringcolor=$foreground --line-uses-inside \
    --keyhlcolor=$letterEnteredColor --bshlcolor=$letterRemovedColor --separatorcolor=$background \
    --insidevercolor=$passwordCorrect --insidewrongcolor=$passwordIncorrect \
    --ringvercolor=$foreground --ringwrongcolor=$foreground --indpos="x+280:h-70" \
    --radius=20 --ring-width=4 --veriftext="" --wrongtext="" \
    --verifcolor="$foreground" --timecolor="$foreground" --datecolor="$foreground" \
    --noinputtext="" --force-clock -n $lockargs


pkill -u "$USER" -USR2 dunst

rm "$tmpbg"
