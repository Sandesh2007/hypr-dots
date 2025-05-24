swww query | grep -oP '(?<=image: ).*' | xargs -I {} sh -c 'magick "{}" -quality 90 ~/.cache/current_wallpaper.png && magick "{}" -quality 90 /home/sandesh/.mozilla/firefox/nst4cois.default-release/chrome/ShyFox/content/current_wallpaper.png &'
# && magick "{}" -quality 90 /home/sandesh/.zen/3om9rwfj.Default\ \(release\)/chrome/ShyFox/content/current_wallpaper.png'
 
