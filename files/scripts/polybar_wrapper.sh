#!/usr/bin/env bash
width=$(smallest_resolution_width.py)

env MIN_WIDTH="$width" polybar -r bar
