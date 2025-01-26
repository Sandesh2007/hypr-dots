#!/bin/bash

killall waybar

sleep 0.5

waybar -c ~/.config/waybar/themes/new/config -s ~/.config/waybar/themes/new/style.css &
