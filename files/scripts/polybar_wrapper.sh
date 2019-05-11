#!/usr/bin/env bash

for m in $(polybar --list-monitors | cut -d ":" -f 1); do
    env MONITOR="$m" polybar --reload bar
done
