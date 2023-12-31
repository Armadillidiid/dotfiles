#!/bin/bash

# Set refresh rate to 60hz
xrandr --output eDP-1 --mode 1920x1080 -r  59.96

# Set screen brightness to 30 percent
# echo 85 > /sys/class/backlight/amdgpu_bl0/brightness
