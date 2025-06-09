#!/usr/bin/env bash
# Screen recording script for Wayland using wf-recorder and slurp

# Setup recording filename and directory
timestamp=$(date +%Y-%m-%d-%H%M%S)
dir="$(xdg-user-dir VIDEOS)/Screenrecords"
filename="$dir/Rec-${timestamp}.mp4"

# Ensure directory exists
[ -d "$dir" ] || mkdir -p "$dir"

# Rofi options (icons for aesthetics)
s_full=""
s_select=""

# Rofi dmenu command
rofi_cmd() {
	rofi -dmenu \
		-p "Record" \
		-mesg "Directory :: $dir" \
		-markup-rows \
		-theme "$HOME/.config/hypr/rofi-themes/Screenshot.rasi"
}

# Rofi launcher
run_rofi() {
	echo -e "$s_full\n$s_select" | rofi_cmd
}

# Notification on success/failure
show_notification() {
    if [[ -e "$filename" ]]; then
        notify-send  -i media-record "Recording" "Recording saved: $filename"
    else
        notify-send -i custom-trash-bin "Recording" "Recording canceled"
    fi
}

# Start full screen recording
record_full() {
    wf-recorder -f "$filename"
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga &>/dev/null
    show_notification
}

# Start region recording
record_select() {
    region=$(slurp)
    [ -z "$region" ] && notify-send "Recording canceled" "No region selected." && exit 1
    wf-recorder -g "$region" -f "$filename"
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga &>/dev/null
    show_notification
}

# Run by CLI or GUI
if [[ -n "$1" ]]; then
    case $1 in
        --now) record_full ;;
        --sel) record_select ;;
    esac
else
    choice=$(run_rofi)
    case "$choice" in
        "$s_full") record_full ;;
        "$s_select") record_select ;;
    esac
fi
