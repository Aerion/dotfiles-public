#!/bin/sh

timeout 3 ping -q -c 1 1.1.1.1 > /dev/null
status=$?
if [ $status -eq 124 ] || [ $status -eq 2 ]; then
    echo "x"
    exit 1
fi

updates_aur=$(yay -Pn 2> /dev/null)
updates_arch=$(checkupdates 2> /dev/null | wc -l)

if [ "$updates_aur" -eq 0 ] && [ "$updates_arch" -eq 0 ]; then
    echo ""
    exit 0
fi

echo "$updates_arch  $updates_aur"
