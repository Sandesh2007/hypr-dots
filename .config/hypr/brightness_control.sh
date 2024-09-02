#!/bin/bash

# Minimum brightness level (in percent)
MIN_BRIGHTNESS=1

# Get the current brightness level in percent
current_brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
current_brightness_percent=$((current_brightness * 100 / max_brightness))

if [ "$1" == "decrease" ]; then
    # Decrease brightness, but not below MIN_BRIGHTNESS
    new_brightness=$((current_brightness_percent - 5))
    if [ "$new_brightness" -lt "$MIN_BRIGHTNESS" ]; then
        new_brightness=$MIN_BRIGHTNESS
    fi
elif [ "$1" == "increase" ]; then
    # Increase brightness
    new_brightness=$((current_brightness_percent + 5))
    if [ "$new_brightness" -gt 100 ]; then
        new_brightness=100
    fi
else
    echo "Usage: $0 {increase|decrease}"
    exit 1
fi

# Set the new brightness level
brightnessctl set "${new_brightness}%"
