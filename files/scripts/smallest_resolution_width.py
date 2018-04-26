#!/usr/bin/env python

from subprocess import check_output
import re

if __name__ == '__main__':
    xrandr_output = check_output(['xrandr']).decode("utf-8")
    matches = re.findall("connected.+?(\d+)x\d+", xrandr_output)
    widths = [int(x) for x in matches]

    # Output the smallest element
    print(min(widths))
