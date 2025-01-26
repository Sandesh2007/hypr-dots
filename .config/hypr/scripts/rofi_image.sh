#!/bin/bash

# Get the name of the current wallpaper
wallpaper_name=$(swww query | grep -oP '(?<=image: ).*' | xargs basename)

# Define the source and destination paths
source_path="$HOME/.cache/$USER/hypr/$wallpaper_name"
destination_path="$HOME/.cache/current_wallpaper_rofi.png"

# Check if the file exists at the source path
if [[ -f "$source_path" ]]; then
    # Copy the wallpaper to the home directory
    cp "$source_path" "$destination_path"
    echo "Wallpaper '$wallpaper_name' copied to your directory."
else
    echo "Wallpaper '$wallpaper_name' not found in '.cache/sandesh/hypr/'."
fi
