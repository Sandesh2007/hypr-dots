mediaRunning=$(cat ~/.cache/waybar/widgetOn)
widgetState=$(cat ~/.cache/widget/widgetState)

if [ "$mediaRunning" == "true" ]; then
    ags --instance players toggle $widgetState
    exit
elif [ "$mediaRunning" == "false" ]; then
    echo "true" > ~/.cache/waybar/widgetOn
    ags run ~/.config/ags/MusicPlayer
    exit
fi
