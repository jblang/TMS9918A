#!/usr/bin/python3

# Display TMS9918A multicolor mode animation on Unix terminal
# Usage: ./nyan.py nyan.bin (bin files stored in nyan subdirectory)

import sys
import time
from colorama import Fore, Style

# TMS9918A color approximations
color = (
        Style.NORMAL + Fore.BLACK, 
        Style.NORMAL + Fore.BLACK, 
        Style.NORMAL + Fore.GREEN,
        Style.BRIGHT + Fore.GREEN,
        Style.NORMAL + Fore.BLUE,
        Style.BRIGHT + Fore.BLUE,
        Style.DIM + Fore.RED,
        Style.NORMAL + Fore.CYAN,
        Style.NORMAL + Fore.RED,
        Style.BRIGHT + Fore.RED,
        Style.NORMAL + Fore.YELLOW,
        Style.BRIGHT + Fore.YELLOW,
        Style.DIM + Fore.GREEN,
        Style.NORMAL + Fore.MAGENTA,
        Style.NORMAL + Fore.WHITE,
        Style.BRIGHT + Fore.WHITE
)


with open(sys.argv[1], 'rb') as f:
    data = f.read()

frames = len(data) // (32 * 48)
while True:
    for frame in range(0, frames):
        print("\x1b[H", end="")
        for y in range(0, 48):
            for x in range(0, 32):
                name = (y // 8) * 32 + x
                byte = frame * (32 * 48) + (name * 8) + (y % 8)
                print(color[data[byte] >> 4] + "\u2588\u2588", end="")
                print(color[data[byte] & 0xf] + "\u2588\u2588", end="")
            print(color[0])
        time.sleep(0.1)
