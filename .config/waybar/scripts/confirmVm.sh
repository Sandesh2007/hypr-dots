#!/bin/bash

# Check if vm is running 
vmRunning=$(cat ~/.cache/waybar/vmRunning)

# Add killVm option if vm is already running
if [[ $vmRunning == "yes" ]]; then
    echo "vm is running already"
    CHOICE=$(echo -e "No\nYes\nkillVm" | rofi -dmenu -i -p "Start vm?"  -theme ~/.config/waybar/rofi/confirm.rasi) #adds new killvm option
else 
    echo "vm is not running"
    CHOICE=$(echo -e "No\nYes" | rofi -dmenu -i -p "Start vm?" -theme ~/.config/waybar/rofi/confirm.rasi)
fi

# Prompt user with a confirmation menu
icon="$HOME/.config/waybar/assets/win11.png"

if [[ $CHOICE == "Yes" ]]; then
    echo "Launching Win11 Vm..."
    dunstify "Launching Win11 Vm" -i $icon -u low
    sh $HOME/.config/waybar/scripts/launchVm.sh
    echo "yes" > ~/.cache/waybar/vmRunning
    

elif [[ $CHOICE == "No" ]]; then
    echo "Launch canceled!!"
    dunstify "Launch canceled" -i $icon -u low
    echo "no" > ~/.cache/waybar/vmRunning

elif [[ $CHOICE == "killVm" ]]; then
    echo "killing running vm"
    dunstify "Killing vm" -i $icon -u low
    sleep 1; vboxmanage controlvm win11 poweroff  #kills the window 11 vm 
    echo "no" > ~/.cache/waybar/vmRunning

else
    echo "canceled!!"
fi
