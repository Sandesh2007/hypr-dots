player=$(playerctl -l | head -n 1)  # Get the first active player
song_info=$(playerctl -p "$player" metadata --format '{{ artist }} - {{ title }}')

# Check if the length of song_info is greater than 50
if [ ${#song_info} -gt 50 ]; then
    song_info="${song_info:0:47}..."
fi

# Display the appropriate icon based on the player
if [ "$player" = "spotify" ]; then
    echo " $song_info  "
elif [ "$player" = "firefox.instance_1_62" ]; then
    echo "  $song_info  "
else
    echo " "
fi
