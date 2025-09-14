#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
WSL_HOME="$HOME"

# Get Windows username from WSL
WIN_USER=$(cmd.exe /C "echo %USERNAME%" | tr -d '\r')
WINDOWS_HOME="/mnt/c/Users/$WIN_USER"

link_file() {
    local src=$1
    local dest=$2
    mkdir -p "$(dirname "$dest")"
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Backing up existing file: $dest -> $dest.bak"
        mv "$dest" "$dest.bak"
    fi
    echo "Creating symlink: $dest -> $src"
    ln -s "$src" "$dest"
}

# Fish config
FISH_SRC="$DOTFILES_DIR/fish/config.fish"
FISH_DEST="$WSL_HOME/.config/fish/config.fish"
link_file "$FISH_SRC" "$FISH_DEST"

# Starship config
STARSHIP_SRC="$DOTFILES_DIR/starship.toml"
STARSHIP_DEST="$WSL_HOME/.config/starship.toml"
link_file "$STARSHIP_SRC" "$STARSHIP_DEST"

# Fish functions
if [ -d "$DOTFILES_DIR/fish/functions" ]; then
    for func_file in "$DOTFILES_DIR/fish/functions/"*.fish; do
        func_name=$(basename "$func_file")
        link_file "$func_file" "$WSL_HOME/.config/fish/functions/$func_name"
    done
fi

# WezTerm config
WEZTERM_SRC="$DOTFILES_DIR/wezterm/wezterm.lua"
WEZTERM_DEST="$WINDOWS_HOME/.wezterm.lua"
cp -f "$DOTFILES_DIR/wezterm/wezterm.lua" "$WEZTERM_DEST"

echo "Installation complete!"
echo "Fish config installed to $FISH_DEST"
echo "WezTerm config installed to $WEZTERM_DEST"
