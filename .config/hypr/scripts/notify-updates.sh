#!/bin/bash

aur_helper=yay
icon="$HOME/.config/hypr/assets/updates.png"
updated_icon="$HOME/.config/hypr/assets/updated.svg"
no_internet_icon="$HOME/.config/hypr/assets/updated.svg"
sound_file="$HOME/.config/hypr/assets/sounds/Windows-notify.wav"

# Check for internet before checking for update
check_network() {
    if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
        return 0  # Network is available
    else
        return 1  # Network is not available
    fi
}

# Play sound function
play_sound() {
    if command -v paplay > /dev/null; then
        paplay "$sound_file" &
    elif command -v aplay > /dev/null; then
        aplay "$sound_file" &
    else
        notify-send "No supported audio player found." "Install 'paplay' or 'aplay'." -i $icon -u normal

    fi
}

if check_network; then
    #sleep 30  # 30 second wait because it may show no updates available at first boot.
    if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
    fi

    if ! updates_aur=$($aur_helper -Qu --aur --quiet | wc -l); then
        updates_aur=0
    fi

# flatpak remote-ls --updates

    updates=$(("$updates_arch" + "$updates_aur"))

    if (( updates > 0 && updates < 100 )); then
        notify-send "Update available" "Updates : $updates" -i $icon -u normal
        play_sound

    elif (( updates >= 100 )); then
        notify-send "System update warning" "<span color='red'>\n Updates: $updates</span>" -i $icon -u critical
        play_sound

    else 
        notify-send "No updates available" "Your system is up to date" -i $updated_icon -u low
        play_sound
    fi
else 
    notify-send "Internet unavailable" "Connect to internet to check for updates" -i $updated_icon -u low
    play_sound
fi
