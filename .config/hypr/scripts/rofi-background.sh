#!/bin/bash

# swww query | grep -oP '(?<=image: ).*' | xargs -I {} sh -c 'magick "{}" -quality 90 ~/.cache/current_wallpaper.png && magick "{}" -quality 90 /home/sandesh/.zen/wqjla8se.Default (release)/chrome/ShyFox/content/current_wallpaper.png &'
# # && magick "{}" -quality 90 /home/sandesh/.zen/3om9rwfj.Default\ \(release\)/chrome/ShyFox/content/current_wallpaper.png'

swww query | grep -oP '(?<=image: ).*' | xargs -I {} sh -c 'magick "{}" -quality 90 ~/.cache/current_wallpaper.png && magick "{}" -quality 90 /home/sandesh/.zen/wqjla8se.Default\ \(release\)/chrome/ShyFox/content/current_wallpaper.png &'
