#!/bin/bash
# Script to extract colors from matugen and update Spicetify color.ini

# Check if matugen is installed
if ! command -v matugen &> /dev/null; then
    echo "Error: matugen is not installed. Install it with 'pip install matugen'"
    exit 1
fi

# Check if spicetify is installed
if ! command -v spicetify &> /dev/null; then
    echo "Error: spicetify is not installed."
    exit 1
fi

# Get current Spicetify theme
CURRENT_THEME=$(spicetify config current_theme | cut -d' ' -f2)
echo "Current Spicetify theme: $CURRENT_THEME"

# Get Spicetify config directory
SPICETIFY_CONFIG_DIR="$HOME/.config/spicetify"
COLOR_INI_PATH="$SPICETIFY_CONFIG_DIR/Themes/$CURRENT_THEME/color.ini"

# Check if color.ini exists
if [ ! -f "$COLOR_INI_PATH" ]; then
    echo "Error: color.ini not found at $COLOR_INI_PATH"
    exit 1
fi

# Backup the original color.ini
cp "$COLOR_INI_PATH" "$COLOR_INI_PATH.backup"
echo "Backed up original color.ini to $COLOR_INI_PATH.backup"

# Extract Material You colors using matugen
echo "Extracting Material You colors from your wallpaper..."
MATUGEN_OUTPUT=$(matugen extract -j)

# Extract specific colors from the matugen output
# Note: We're using simple grep/cut for parsing JSON which works for basic cases
extract_color() {
    COLOR_NAME=$1
    echo "$MATUGEN_OUTPUT" | grep -o "\"$COLOR_NAME\":\"#[^\"]*" | cut -d'"' -f4 | sed 's/#//'
}

# Get Material You colors
PRIMARY=$(extract_color "primary")
ON_PRIMARY=$(extract_color "onPrimary")
PRIMARY_CONTAINER=$(extract_color "primaryContainer")
ON_PRIMARY_CONTAINER=$(extract_color "onPrimaryContainer")
SECONDARY=$(extract_color "secondary")
ON_SECONDARY=$(extract_color "onSecondary")
SECONDARY_CONTAINER=$(extract_color "secondaryContainer")
ON_SECONDARY_CONTAINER=$(extract_color "onSecondaryContainer")
TERTIARY=$(extract_color "tertiary")
ON_TERTIARY=$(extract_color "onTertiary")
BACKGROUND=$(extract_color "background")
ON_BACKGROUND=$(extract_color "onBackground")
SURFACE=$(extract_color "surface")
ON_SURFACE=$(extract_color "onSurface")
SURFACE_VARIANT=$(extract_color "surfaceVariant")
ON_SURFACE_VARIANT=$(extract_color "onSurfaceVariant")
ERROR=$(extract_color "error")
ON_ERROR=$(extract_color "onError")

# Get the current theme section name from color.ini
THEME_SECTION=$(grep -o "^\[.*\]" "$COLOR_INI_PATH" | head -1)

# Create a new color.ini with Material You colors
echo "Updating color.ini with Material You colors..."

# Create a temporary file
TMP_FILE=$(mktemp)

# Write the theme section to the temporary file
echo "$THEME_SECTION" > "$TMP_FILE"

# Map Spicetify color variables to Material You colors
cat >> "$TMP_FILE" << EOF
text               = $ON_SURFACE
subtext            = $ON_SURFACE_VARIANT
main               = $SURFACE
sidebar            = $SURFACE_VARIANT
player             = $SURFACE
card               = $SURFACE_VARIANT
shadow             = 000000
selected-row       = $PRIMARY_CONTAINER
button             = $PRIMARY
button-active      = $PRIMARY_CONTAINER
button-disabled    = $SURFACE_VARIANT
tab-active         = $PRIMARY
notification       = $TERTIARY
notification-error = $ERROR
misc               = $SECONDARY
EOF

# Replace the color.ini file
mv "$TMP_FILE" "$COLOR_INI_PATH"

echo "Updated $COLOR_INI_PATH with Material You colors"

# Apply the changes
echo "Applying changes to Spicetify..."
spicetify apply

echo "Done! Spicetify is now using Material You colors with your current theme."
echo "If you want to revert to the original colors, run:"
echo "  mv \"$COLOR_INI_PATH.backup\" \"$COLOR_INI_PATH\" && spicetify apply"
