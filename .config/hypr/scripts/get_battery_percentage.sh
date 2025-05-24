#!/bin/bash

BATTERY_PERCENT=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
BATTERY_STATE=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

function batteryState(){

    if [[ $BATTERY_STATE == "Charging" ]]; then
        echo "Charging "
    fi

    if [[ $BATTERY_STATE == "Discharging" ]]; then
        echo "Discharging"
    fi
}

function batteryPercentage(){

    if [[ $BATTERY_PERCENT > 90 ]]; then
        echo "$BATTERY_PERCENT% "

    elif [[ $BATTERY_PERCENT > 60 ]]; then
        echo "$BATTERY_PERCENT% "

    elif [[ $BATTERY_PERCENT > 40 ]]; then
        echo "$BATTERY_PERCENT% "

    elif [[ $BATTERY_PERCENT > 20 ]]; then
        echo "$BATTERY_PERCENT% "

    elif [[ $BATTERY_PERCENT < 15  ]]; then
        echo "$BATTERY_PERCENT% "
    fi
}

case $1 in
    state)
    batteryState
    ;;

    percentage)
    batteryPercentage
    ;;

    *)
    echo "no"
    ;;
esac