#!/usr/bin/env bash

options=(
    ""
    ""
    ""
    ""
    ""
)

rofi_cmd() {
	rofi -dmenu \
		-p "Goodbye ${USER}" \
		-mesg "Uptime: $(uptime -p | sed -e 's/up //g')" \
		-theme "$HOME"/.config/hypr/rofi-themes/PowerMenu.rasi
}

chosen=$(printf "%s\n" "${options[@]}" | rofi_cmd)

case $chosen in
    "")
        systemctl poweroff
        ;;
    "")
        systemctl reboot
        ;;
    "")
        hyprlock
        ;;
    "")
        systemctl suspend
        ;;
    "")
        sleep 1; hyprctl dispatch exit
        ;;
esac
