#!/bin/bash

APP_NAME=$1
THEME=$2
MENU_TABS=$3

# Definir as cores com base no tema
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

# Construir os itens do menu
MENU_ITEMS='[
  { "label": "Home", "link": "/" }'

IFS=',' read -r -a TABS <<< "$MENU_TABS"
for TAB in "${TABS[@]}"; do
  LINK=$(echo "$TAB" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  MENU_ITEMS+=', { "label": "'"$TAB"'", "link": "/'"$LINK"'" }'
done

MENU_ITEMS+=']'

# Gerar o JSON
cat <<EOF > settings.json
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

echo "Generated settings.json:"
cat settings.json
pwd
ls -l settings.json
