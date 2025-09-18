#!/usr/bin/env bash
set -e

# --- Configuration ---
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Helper Functions ---
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

install_brew_package() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Add Homebrew to PATH for this session
        if [[ "$(uname)" == "Linux" ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        else
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
    echo "Installing $* via Homebrew..."
    brew install "$@"
}

# --- Installation Functions ---
install_dependencies() {
    echo "Installing dependencies via Homebrew..."
    install_brew_package "fish" "starship" "fastfetch" "mise" "wezterm" "neovim"
}

set_default_shell() {
    FISH_PATH="$(command -v fish)"
    if [ -f /etc/shells ] && ! grep -q "$FISH_PATH" /etc/shells; then
        echo "Adding fish to /etc/shells"
        echo "$FISH_PATH" | sudo tee -a /etc/shells
    fi
    echo "Setting fish as the default shell"
    chsh -s "$FISH_PATH"
}

install_fisher_and_plugins() {
    echo "Installing fisher and plugins..."
    if ! fish -c "type fisher" &> /dev/null; then
        echo "Installing fisher..."
        fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
    else
        echo "fisher is already installed."
    fi
}

# --- Setup Function ---
setup_dotfiles() {
    # Fish config
    FISH_SRC="$DOTFILES_DIR/fish/config.fish"
    FISH_DEST="$HOME/.config/fish/config.fish"
    link_file "$FISH_SRC" "$FISH_DEST"

    # Starship config
    STARSHIP_SRC="$DOTFILES_DIR/starship.toml"
    STARSHIP_DEST="$HOME/.config/starship.toml"
    link_file "$STARSHIP_SRC" "$STARSHIP_DEST"

    # Fish functions
    FISH_FUNCTIONS_SRC="$DOTFILES_DIR/fish/functions"
    FISH_FUNCTIONS_DEST="$HOME/.config/fish/functions"
    link_file "$FISH_FUNCTIONS_SRC" "$FISH_FUNCTIONS_DEST"

    # WezTerm config
    WEZTERM_SRC="$DOTFILES_DIR/wezterm/wezterm.lua"
    WEZTERM_DEST="$HOME/.config/wezterm/wezterm.lua"
    link_file "$WEZTERM_SRC" "$WEZTERM_DEST"

    # Mise config
    MISE_SRC="$DOTFILES_DIR/mise/config.toml"
    MISE_DEST="$HOME/.config/mise/config.toml"
    link_file "$MISE_SRC" "$MISE_DEST"

    # Neovim config
    NVIM_SRC="$DOTFILES_DIR/nvim"
    NVIM_DEST="$HOME/.config/nvim"
    link_file "$NVIM_SRC" "$NVIM_DEST"

    echo "Dotfiles setup complete!"
}

# --- Main Logic ---
usage() {
    echo "Usage: $0 [ --full-install | --setup-dotfiles | --help ]"
    echo
    echo "  --full-install      Install all tools and setup dotfiles."
    echo "  --setup-dotfiles    Only setup the dotfiles."
    echo "  --help              Display this help message."
}

if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --full-install)
            install_dependencies
            set_default_shell
            install_fisher_and_plugins
            setup_dotfiles
            shift
            ;; 
        --setup-dotfiles)
            setup_dotfiles
            shift
            ;; 
        --help)
            usage
            shift
            ;; 
        *)
            echo "Unknown parameter passed: $1"
            usage
            exit 1
            ;; 
    esac
done