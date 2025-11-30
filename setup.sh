#!/usr/bin/env sh

# First, run updates
sudo pacman -Syu

# Install Firefox & Thunderbird, with the right localization.
LANGCODE=$(locale | grep LANG | cut -d= -f2 | cut -d_ -f1)
sudo pacman -S --needed --noconfirm firefox firefox-i18n-$LANGCODE thunderbird thunderbird-i18n-$LANGCODE

# Configure terminal apps & tools
sudo pacman -S --needed --noconfirm alacritty ghostty otf-firamono-nerd ttf-firacode-nerd bat zoxide lsd starship zellij

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

mkdir -p ~/.config/alacritty
cat <<'EOF' > ~/.config/alacritty/alacritty.toml
[font]
size = 14
normal = { family = "FiraCode Nerd Font" }

[window]
opacity = 0.75
EOF

mkdir -p ~/.config/ghostty
cat <<'EOF' > ~/.config/ghostty/config
font-size = 14
font-family = "FiraCode Nerd Font"
background-opacity = 0.75
EOF

starship preset gruvbox-rainbow -o ~/.config/starship.toml

# Install some more CLI tools
sudo pacman -S --needed --noconfirm git openssh btop jq yq lazygit dysk github-cli impala bluetui 

# Install Bitwarden & Signal
sudo pacman -S --needed --noconfirm bitwarden signal-desktop

# Install JDK & Maven
sudo pacman -S --needed --noconfirm jdk-openjdk openjdk-doc openjdk-src maven gradle kotlin clojure leiningen

# Install and enable Docker
sudo pacman -S --needed --noconfirm docker docker-compose lazydocker ducker
sudo systemctl enable docker.socket
sudo usermod -aG docker $USER

# Install IDE's
sudo pacman -S --needed --noconfirm code intellij-idea-community-edition

# Install Flatpak's
sudo pacman -S --needed --noconfirm flatpak
sudo flatpak install --noninteractive flathub com.google.Chrome
sudo flatpak install --noninteractive flathub com.microsoft.Edge
sudo flatpak install --noninteractive flathub com.heroicgameslauncher.hgl
sudo flatpak install --noninteractive flathub com.spotify.Client

# Print some colorful stuff to finish up
sudo pacman -S --needed --noconfirm fastfetch lolcat
fastfetch | lolcat

