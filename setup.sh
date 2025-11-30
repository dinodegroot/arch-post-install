#!/usr/bin/env sh

# First, install Firefox & Thunderbird, with the right localization.
LANGCODE=$(locale | grep LANG | cut -d= -f2 | cut -d_ -f1)
sudo pacman -Sy --needed firefox firefox-i18n-$LANGCODE thunderbird thunderbird-i18n-$LANGCODE

# Configure terminal apps & tools
sudo pacman -Sy --needed alacritty ghostty otf-firamono-nerd ttf-firacode-nerd bat zoxide lsd starship zellij
cat <<'EOF' > ~/.bashrc
[[ $- != *i* ]] && return

alias ls='lsd --color=auto'
alias cd='z'
alias cat='bat'
PS1='[\u@\h \W]\$ '

if [ "$TERM" == alacritty ]; then
    eval "$(zellij setup --generate-auto-start bash)"
    eval "$(zellij setup --generate-completion bash)"
fi

eval "$(starship init bash)"
eval "$(zoxide init bash)"
EOF

mkdir -p ~/.config/lsd
if [ ! -f ~/.config/lsd/config.yaml ]; then
    cat <<'EOF' > ~/.config/lsd/config.yaml
classic: false
blocks:
  - permission
  - user
  - group
  - size
  - date
  - name
color:
  when: auto
  theme: default
date: '+%Y-%m-%dT%H:%M:%S%z'
dereference: false
icons:
  when: auto
  theme: fancy
  separator: " "
indicators: false
layout: grid
recursion:
  enabled: false
size: default
sorting:
  column: name
  reverse: false
  dir-grouping: none
no-symlink: false
total-size: false
hyperlink: never
symlink-arrow: =>
header: false
literal: false
truncate-owner:
  after:
  marker: ""
EOF
fi

mkdir -p ~/.config/alacritty
if [ ! -f ~/.config/alacritty/alacritty.toml ]; then
    cat <<'EOF' > ~/.config/alacritty/alacritty.toml
[font]
size = 14
normal = { family = "FiraCode Nerd Font" }

[window]
opacity = 0.75
EOF
fi

mkdir -p ~/.config/ghostty
if [ ! -f ~/.config/ghostty/config ]; then
    cat <<'EOF' > ~/.config/ghostty/config
font-size = 14
font-family = "FiraCode Nerd Font"
background-opacity = 0.75
EOF
fi

if [ ! -f ~/.config/starship.toml ]; then
    starship preset gruvbox-rainbow -o ~/.config/starship.toml
fi

# Install some more CLI tools
sudo pacman -Sy --needed git openssh htop bashtop jq yq lazygit ducker dysk

