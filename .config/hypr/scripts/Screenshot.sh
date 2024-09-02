#!/usr/bin/env bash
#  Screenshot script for Wayland using grim and wl-copy

# Screenshot general options
timestamp=$(date +%Y-%m-%d-%H%M%S)
dir="$(xdg-user-dir PICTURES)/ScreenShots"
filename="$dir/Shot-${timestamp}.png"

# Create dir if not exists
[ -d "$dir" ] || mkdir -p "$dir"

# Rofi options
s_full=""
s_select=""
s_active=""
s_in3="󰔝"
s_in10="󰔜"

rofi_cmd() {
	rofi -dmenu \
		-p Screenshot \
		-mesg "Directory :: $dir" \
		-markup-rows \
		-theme "$HOME"/.config/bspwm/src/rofi-themes/Screenshot.rasi
}

run_rofi() {
	echo -e "$s_full\n$s_select\n$s_active\n$s_in3\n$s_in10" | rofi_cmd
}

show_notification() {
    if [[ -e "$filename" ]]; then
        dunstify --replace=699 -i "$filename" "Screenshot" "Screenshot saved and copied to clipboard"
    else
        dunstify --replace=699 -i custom-trash-bin "Screenshot" "Screenshot Canceled"
    fi
}

copy_screenshot() {
	wl-copy < "$filename"
}

take_screenshot() {
    grim "$@" "$filename" && paplay /usr/share/sounds/freedesktop/stereo/screen-capture.oga &>/dev/null | copy_screenshot
    show_notification
}

take_screenshot_select() {
    grim -g "$(slurp)" "$filename" && paplay /usr/share/sounds/freedesktop/stereo/screen-capture.oga &>/dev/null | copy_screenshot
    show_notification
}

countdown() {
    for sec in $(seq "$1" -1 1); do
        dunstify -t 300 -i  ~/.config/bspwm/assets/screenshot.png "Taking shot in : $sec"
        sleep 1
    done
}

run_cmd() {
case $1 in
    --now)
        sleep 0.5 && take_screenshot ;;
    --sel)
        take_screenshot_select ;;
    --active)
        sleep 3 && take_screenshot -o active ;;
    --in3)
		countdown 3 && take_screenshot ;;
    --in10)
        countdown 10 && take_screenshot ;;
esac
}

select_option="$(run_rofi)"
case ${select_option} in
	"$s_full")
		run_cmd --now ;;
	"$s_select")
		run_cmd --sel ;;
	"$s_active")
		run_cmd --active ;;
	"$s_in3")
		run_cmd --in3 ;;
	"$s_in10")
		run_cmd --in10 ;;
esac
