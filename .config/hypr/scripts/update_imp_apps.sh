#!/bin/bash

# colors
GREEN="\e[32m"
RED="\e[31m"
ENDCOLOR="\e[0m"

# app to update
apps=("firefox" "spotify" "visual-studio-code-bin")

echo ""
echo "Checking for updates..."
echo ""

updates=()

for app in "${apps[@]}"; do
  if yay -Qu "$app" &>/dev/null; then
    updates+=("$app")
    echo -e "Update is available for ${RED}$app${ENDCOLOR}"
  else
    echo -e "${GREEN}$app is already up-to-date. ${ENDCOLOR}"
  fi
done

if [[ ${#updates[@]} -gt 0 ]]; then
  echo ""
  echo "Updating: ${updates[*]}"
  yay -S "${updates[@]}"
else
  echo ""
  echo -e "${GREEN}All apps are already up-to-date. ${ENDCOLOR}"
fi
