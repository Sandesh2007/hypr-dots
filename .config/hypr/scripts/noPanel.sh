panel=waybar
no_Panel_icon="$HOME/.config/hypr/assets/dunst/noPanel.svg"
Panel_icon="$HOME/.config/hypr/assets/dunst/Panel.svg"

if pgrep -x waybar >/dev/null; then
    pkill $panel
    echo "killed $panel"
    dunstify -u normal -I $no_Panel_icon "Entered no panel mode" "killed $panel"
else
    sh ~/.config/waybar/launch.sh
    echo "started $panel"
    dunstify -u normal -I $Panel_icon "Exited no panel mode" "started $panel"
fi