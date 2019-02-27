#!/usr/bin/env bash

for m in $(xrandr --listactivemonitors | rev | cut -d " " -f -1 | rev); do
    if ! [[ $m =~ ^[1-9]$ ]]; then
        env MONITOR="$m" polybar --reload bar
    fi
done
