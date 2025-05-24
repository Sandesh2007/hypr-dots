current_rofi=$(cat ~/.cache/rofi/current-theme)
confDir="$HOME/.config/"
rofiConf="${confDir}/rofi/selector.rasi"
rofiStyleDir="${confDir}/rofi/styles"
rofiAssetDir="${confDir}/rofi/assets"

rofi -show drun -theme "${rofiStyleDir}/style_${current_rofi}.rasi"
