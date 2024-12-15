#!/bin/bash

APP_NAME=$1
THEME=$2
MENU_TABS=$3

# Define color schemes based on the theme
if [[ "$THEME" == "dark" ]]; then
  PRIMARY="#FFA500"
  SECONDARY="#F97700"
  ACCENT="#fbe36a"
  TEXT_LIGHT="#ffffff"
  TEXT_DARK="#000000"
  BACKGROUND_DARK="#252525"
  MODULE_BACKGROUND="rgba(68, 68, 68, 0.6)"
else
  PRIMARY="#007BFF"
  SECONDARY="#0056b3"
  ACCENT="#33ccff"
  TEXT_LIGHT="#000000"
  TEXT_DARK="#ffffff"
  BACKGROUND_DARK="#f8f9fa"
  MODULE_BACKGROUND="rgba(255, 255, 255, 0.8)"
fi

# Start building the menuItems array
MENU_ITEMS='[
  { "label": "Home", "link": "/" }'

# Add custom menu tabs if provided
IFS=',' read -r -a TABS <<< "$MENU_TABS"
for TAB in "${TABS[@]}"; do
  LINK=$(echo "$TAB" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  MENU_ITEMS+=', { "label": "'"$TAB"'", "link": "/'"$LINK"'" }'
done

# Close the menuItems array
MENU_ITEMS+=']'

# Generate the JSON configuration
cat <<EOF > palette.json
{
  "companyName": "$APP_NAME",
  "maxWidth": "70rem",
  "headerCompanyNameDisplay": "none",
  "headerLogoHeight": "6.5rem",
  "hoverFontSize": "1rem",
  "borderStyle": "dashed",
  "colors": {
    "primary": "$PRIMARY",
    "secondary": "$SECONDARY",
    "accent": "$ACCENT",
    "textLight": "$TEXT_LIGHT",
    "textDark": "$TEXT_DARK",
    "backgroundDark": "$BACKGROUND_DARK",
    "moduleBackground": "$MODULE_BACKGROUND"
  },
  "menuItems": $MENU_ITEMS
}
EOF

echo "Generated palette.json:"
cat palette.json
