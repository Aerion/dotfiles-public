#!/usr/bin/env bash

pkill polybar

launch_single_bar() {
    polybar --reload single &
}

if ! type "xrandr" > /dev/null; then
    echo "Launching single bar as xrandr is not installed"
    launch_single_bar
    exit 0
fi

monitors=$(xrandr --listactivemonitors | tail -n +2 | grep -oE '\S+$')
monitor_count=$(echo "$monitors" | wc -l)

if [ "$monitor_count" -eq 1 ]; then
    echo "Launching single bar as there is a single ($monitor_count) monitor"
    launch_single_bar
    exit 0
fi

main_monitor=$(echo -n "$monitors" | head -n 1)
echo "main: $main_monitor"
MONITOR="$main_monitor" polybar --reload main &

for m in $(echo -n "$monitors" | tail -n +2); do
    echo "other: $m"
    MONITOR="$m" polybar --reload other &
done