#!/bin/sh

COLOR_OK="$(xrdb -q | awk '/\*\.color7:/ {print $2}')"
COLOR_WARN="$(xrdb -q | awk '/\*\.color8:/ {print $2}')"
COLOR_DANGER="$(xrdb -q | awk '/\*\.color1:/ {print $2}')"

DEFAULT="%{F-}"
OK="%{F${COLOR_OK}}"
WARN="%{F${COLOR_WARN}}"
DANGER="%{F${COLOR_DANGER}}"

MEM=`awk '/MemAvailable/ {printf "%.1f", int($2*10/1048576)/10}' /proc/meminfo`

COLOR="$OK"
if [[ ${MEM%%.*} -le 2 ]]; then
  COLOR="$DANGER"
elif [[ ${MEM%%.*} -le 4 ]]; then
  COLOR="$WARN"
fi

echo -ne "${COLOR}${MEM}${DEFAULT} GB"
