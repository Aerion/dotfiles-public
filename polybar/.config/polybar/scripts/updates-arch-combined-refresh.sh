#!/bin/sh

for p in $(pidof polybar); do
    polybar-msg -p $p hook updates-arch-combined 1;
done
