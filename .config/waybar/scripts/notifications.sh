#!/bin/bash
# Show the number of notifications.

count=$(swaync-client -c)
icon=$(swaync-client -swb) # or just use an icon if you're formatting it differently

echo "{\"text\": \"$icon\", \"tooltip\": \"$count notifications\"}"
