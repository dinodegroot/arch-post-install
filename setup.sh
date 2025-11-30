#!/usr/bin/env sh

# First, install Firefox & Thunderbird, with the right localization.
LANGCODE=$(locale | grep LANG | cut -d= -f2 | cut -d_ -f1)
sudo pacman -S --needed firefox firefox-i18n-$LANGCODE thunderbird thunderbird-i18n-$LANGCODE

