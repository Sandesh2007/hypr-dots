#!/bin/bash

WALLPAPER_PATH="$HOME/.cache/current_wallpaper.png"
WAYBAR_CONFIG_DIR="$HOME/.config/waybar/themes/Claude/"

# Generate Material You colors from wallpaper
matugen image "$WALLPAPER_PATH" --json hex --mode dark >"$WAYBAR_CONFIG_DIR/colors.json"

# Extract "dark" theme colors from the correct path
jq -r '.colors.dark | to_entries | map("@define-color matugen_\(.key) \(.value);") | .[]' \
  "$WAYBAR_CONFIG_DIR/colors.json" >"$WAYBAR_CONFIG_DIR/colors.css"

# Reload waybar
killall -SIGUSR2 waybar
