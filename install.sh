#!/bin/bash
# Dotfiles install script — kør på en ny maskine efter:
# git clone git@github.com:MagnusBVillumsen/dotfiles ~/dotfiles

DOTFILES="$HOME/dotfiles"
set -e

echo "Installerer dotfiles..."

# Mapper der skal eksistere
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/tmux

# Symlinks
ln -sf "$DOTFILES/nvim"                       ~/.config/nvim
ln -sf "$DOTFILES/alacritty/alacritty.toml"  ~/.config/alacritty/alacritty.toml
ln -sf "$DOTFILES/tmux/tmux.conf"             ~/.config/tmux/tmux.conf
ln -sf "$DOTFILES/starship/starship.toml"     ~/.config/starship.toml
ln -sf "$DOTFILES/zsh/.zshrc"                 ~/.zshrc

# Pi coding agent
mkdir -p ~/.pi/agent
ln -sf "$DOTFILES/pi/AGENTS.md"    ~/.pi/agent/AGENTS.md
ln -sf "$DOTFILES/pi/settings.json" ~/.pi/agent/settings.json

echo ""
echo "Færdig! Installer pakker:"
echo "  sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting starship fzf tmux neovim git ttf-jetbrains-mono-nerd wl-clipboard bat ripgrep fd unzip nodejs npm deno stylua clang python-pipx"
echo ""
echo "Sæt zsh som shell:"
echo "  chsh -s /usr/bin/zsh"
