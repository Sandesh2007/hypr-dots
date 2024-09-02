#!/bin/bash

# Default temperature
TEMP_FILE="$HOME/.config/hypr/temp_setting"
DEFAULT_TEMP=4000

# Create temp file if it doesn't exist
if [ ! -f "$TEMP_FILE" ]; then
    echo $DEFAULT_TEMP > $TEMP_FILE
fi

# Get the current temperature
CURRENT_TEMP=$(cat "$TEMP_FILE")

# Adjust the temperature based on the input argument
if [ "$1" == "up" ]; then
    NEW_TEMP=$((CURRENT_TEMP + 1000))
elif [ "$1" == "down" ]; then
    NEW_TEMP=$((CURRENT_TEMP - 1000))
else
    NEW_TEMP=$DEFAULT_TEMP
fi

# Limit the temperature range
if [ "$NEW_TEMP" -lt 1000 ]; then
    NEW_TEMP=1000
elif [ "$NEW_TEMP" -gt 10000 ]; then
    NEW_TEMP=10000
fi

# Set the new temperature and update the temp file
gammastep -O $NEW_TEMP
echo $NEW_TEMP > $TEMP_FILE
