#!/bin/bash

# To add new theme just create a new directory at ~/.config/waybar/themes/newtheme and add the config, style.css. 
# This script will automatically detect the folder and use the config and style from the theme.

# Path to the Waybar themes folder
themes_path="$HOME/.config/waybar/themes"

# Generate options dynamically based on folder names
options=$(ls -d $themes_path/* | xargs -n 1 basename)

# Use rofi with a custom .rasi file
choice=$(echo -e "$options" | rofi -dmenu -p "Choose Waybar Theme:" -theme ~/.config/waybar/rofi/waybar-theme.rasi)

# Check if a valid choice was made
if [[ -n "$choice" && -d "$themes_path/$choice" ]]; then
    # Update current-theme file
    echo "$choice" > ~/.cache/waybar/current-theme

    # Launch Waybar with the new theme
    ~/.config/waybar/launch.sh
else
    echo "No valid option chosen or directory doesn't exist."
fi
