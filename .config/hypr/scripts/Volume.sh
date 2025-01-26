#!/usr/bin/env bash
#  ██╗   ██╗ ██████╗ ██╗     ██╗   ██╗███╗   ███╗███████╗
#  ██║   ██║██╔═══██╗██║     ██║   ██║████╗ ████║██╔════╝
#  ██║   ██║██║   ██║██║     ██║   ██║██╔████╔██║█████╗
#  ╚██╗ ██╔╝██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══╝
#   ╚████╔╝ ╚██████╔╝███████╗╚██████╔╝██║ ╚═╝ ██║███████╗
#    ╚═══╝   ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝
#
#

# Icons
vol_dir="$HOME/.config/hypr/assets/dunst/"
notify_cmd='dunstify -u low -h string:x-dunst-stack-tag:cvolum'
sound_file="$HOME/.config/hypr/assets/sounds/volume.wav"

# Get Volume
get_volume() {
    pamixer --get-volume-human | sed 's/%//'
}

# Play sound function
play_sound() {
    if command -v paplay > /dev/null; then
        paplay "$sound_file" &
    elif command -v aplay > /dev/null; then
        aplay "$sound_file" &
    else
        dunstify "No supported audio player found." "Install 'paplay' or 'aplay'." -i $icon -u normal

    fi
}

# Get icons
get_icon() {
    current="$(get_volume)"

    if [[ "$current" == "muted" || "$current" -eq "0" ]]; then
        icon="$vol_dir/volume-mute.png"
    elif [[ "$current" -le 30 ]]; then
        icon="$vol_dir/volume-low.png"
    elif [[ "$current" -le 70 ]]; then
        icon="$vol_dir/volume-mid.png"
    else
        icon="$vol_dir/volume-high.png"
    fi
}


# Notify
notify_user() {
    ${notify_cmd} -i "$icon" "Volume : $(get_volume)%"
}

# Adjust Volume
adjust_volume() {
    [[ $(pamixer --get-mute) == true ]] && pamixer -u
    pamixer --allow-boost --set-limit 150 "$1" "$2" && get_icon && notify_user
    play_sound
}

# Toggle Mute
toggle_mute() {
    if [[ $(pamixer --get-mute) == false ]]; then
        pamixer --toggle-mute
        get_icon
        message="Mute"
    else
        pamixer --toggle-mute
        get_icon
        message="Unmute"
    fi
    ${notify_cmd} -i "$icon" "$message"
    play_sound
}

# Execute accordingly
if command -v pamixer &>/dev/null; then
    case "$1" in
        --get) get_volume ;;
        --inc) adjust_volume -i 5 ;;
        --dec) adjust_volume -d 5 ;;
        --toggle) toggle_mute ;;
        *) echo "$(get_volume)%" ;;
    esac
else
    ${notify_cmd} "'pamixer' is not installed."
fi
