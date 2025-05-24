#!/bin/bash

# Check if waybar-disabled file exists
if [ -f $HOME/.cache/waybar-disabled ] ;then 
    killall waybar
    pkill waybar
    exit 1 
fi

# ----------------------------------------------------- 
# Quit all running waybar instances
# ----------------------------------------------------- 
killall waybar
pkill waybar
sleep 0.5

waybar -c ~/.config/waybar/themes/sane1090x/config -s ~/.config/waybar/themes/sane1090x/style.css &