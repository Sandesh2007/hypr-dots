#!/bin/bash

# Directory to store clipboard history
CLIPBOARD_DIR="$HOME/.clipboard_history"
CLIPBOARD_FILE="$CLIPBOARD_DIR/history.txt"

# Create directory if it doesn't exist
mkdir -p "$CLIPBOARD_DIR"

# Get current clipboard content
current_clip=$(wl-paste)

# Save clipboard content to history if it's not empty and not the same as the last entry
if [[ -n "$current_clip" && "$(tail -n 1 "$CLIPBOARD_FILE")" != "$current_clip" ]]; then
    echo "$current_clip" >> "$CLIPBOARD_FILE"
fi

# Display clipboard history with Rofi
selected=$(tac "$CLIPBOARD_FILE" | rofi -dmenu -p "Clipboard History" -theme "~/.config/hypr/rofi-themes/Clipboard.rasi")

# Copy the selected item back to the clipboard
if [[ -n "$selected" ]]; then
    echo "$selected" | wl-copy
fi
