#!/bin/bash

# Define Font Awesome icons for different device types
SPEAKER_ICON=""  #default icon
BLUETOOTH_ICON=""  #bluetooth device icon
UNKNOWN_ICON=""  #unknown device icon

# Fetch the list of sinks and dynamically assign icons
SINKS=$(pactl list sinks short | awk '{print $1 "\t" $2}' | while read -r LINE; do
    DEVICE_ID=$(echo "$LINE" | awk '{print $1}')
    DEVICE_NAME=$(echo "$LINE" | awk '{print $2}')

    # Assign icons based on the device type
    if [[ "$DEVICE_NAME" == *"analog-stereo"* ]]; then
        ICON="$SPEAKER_ICON"
    elif [[ "$DEVICE_NAME" == *"bluez_output"* ]]; then
        ICON="$BLUETOOTH_ICON"
    else
        ICON="$UNKNOWN_ICON"
    fi

    # Format output with icon and name
    echo "$DEVICE_ID:<span font='Font Awesome 6 Free Solid 12'>$ICON</span> $DEVICE_NAME"
done)

# Use Rofi to display the menu with the custom Rasi theme
CHOSEN=$(echo -e "$SINKS" | rofi -dmenu -markup-rows -theme ~/.config/hypr/rofi-themes/Audio_switch.rasi -p "Select Audio Output:")

# Exit if no selection is made
[ -z "$CHOSEN" ] && exit 0

# Extract the chosen sink ID
CHOSEN_ID=$(echo "$CHOSEN" | awk -F ':' '{print $1}')

# Set the selected sink as the default
pactl set-default-sink "$CHOSEN_ID"

# Move all currently playing streams to the new sink
for STREAM in $(pactl list sink-inputs short | awk '{print $1}'); do
    pactl move-sink-input "$STREAM" "$CHOSEN_ID"
done
