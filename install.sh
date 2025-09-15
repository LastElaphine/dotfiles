#!/usr/bin/env bash
set -e

# --- Configuration ---
DOTFILES_DIR="$HOME/dotfiles"
WSL_HOME="$HOME"

# --- Helper Functions ---

detect_os() {
    if [[ "$(uname)" == "Linux" ]]; then
        if grep -q Microsoft /proc/version; then
            echo "WSL"
        else
            echo "Linux"
        fi
    elif [[ "$(uname)" == "Darwin" ]]; then
        echo "macOS"
    else
        echo "Unknown"
    fi
}

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

# --- Installation Functions ---
install_fish() {
    if command -v fish &> /dev/null; then
        echo "fish is already installed."
    else
        echo "Installing fish..."
        case "$(detect_os)" in
            "Linux")
                sudo apt-add-repository ppa:fish-shell/release-3
                sudo apt-get update
                sudo apt-get install -y fish
                ;; 
            "macOS")
                brew install fish
                ;; 
            *)
                echo "Unsupported OS for fish installation."
                exit 1
                ;; 
        esac
    fi
    # Set fish as the default shell
    if [ -f /etc/shells ] && ! grep -q "$(which fish)" /etc/shells; then
        echo "Adding fish to /etc/shells"
        which fish | sudo tee -a /etc/shells
    fi
    echo "Setting fish as the default shell"
    chsh -s "$(which fish)"
}

install_starship() {
    if command -v starship &> /dev/null; then
        echo "Starship is already installed."
    else
        echo "Installing Starship..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi
}

install_fastfetch() {
    if command -v fastfetch &> /dev/null; then
        echo "fastfetch is already installed."
    else
        echo "Installing fastfetch..."
        local OS_TYPE=$(detect_os)
        local ARCH=$(uname -m)

        case "$OS_TYPE" in
            "Linux"|"WSL")
                echo "For Debian/Ubuntu (20.04+ / 11+), it's recommended to download the .deb package manually."
                echo "Please visit the latest fastfetch GitHub releases page to download the appropriate package for your architecture:"
                echo "https://github.com/fastfetch-cli/fastfetch/releases/latest"
                echo "Look for a file like 'fastfetch-linux-${ARCH}.deb' or 'fastfetch-linux-${ARCH}.tar.gz'."
                echo "After downloading, you can install the .deb package using: sudo dpkg -i <downloaded_file.deb>"
                ;;
            "macOS")
                echo "For macOS, it's recommended to install fastfetch via Homebrew."
                if ! command -v brew &> /dev/null; then
                    echo "Homebrew not found. Installing Homebrew..."
                    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                fi
                brew install fastfetch
                ;;
            *)
                echo "Unsupported OS for fastfetch installation. Please refer to the fastfetch GitHub page for manual installation instructions:"
                echo "https://github.com/fastfetch-cli/fastfetch"
                exit 1
                ;;
        esac
    fi
}

install_nvm() {
    if [ -d "$HOME/.nvm" ]; then
        echo "nvm is already installed."
    else
        echo "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    fi
}

install_fisher_and_plugins() {
    echo "Installing fisher and plugins..."
    if ! fish -c "type fisher" &> /dev/null; then
        echo "Installing fisher..."
        fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
    else
        echo "fisher is already installed."
    fi
    echo "Installing nvm.fish..."
    fish -c "fisher install jorgebucaran/nvm.fish"
}

# --- Setup Function ---
setup_dotfiles() {
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
    if [[ "$(detect_os)" == "WSL" ]]; then
        WIN_USER=$(cmd.exe /C "echo %USERNAME%" | tr -d '\r')
        WINDOWS_HOME="/mnt/c/Users/$WIN_USER"
        WEZTERM_DEST="$WINDOWS_HOME/.wezterm.lua"
        cp -f "$DOTFILES_DIR/wezterm/wezterm.lua" "$WEZTERM_DEST"
        echo "WezTerm config installed to $WEZTERM_DEST"
    else
        WEZTERM_DEST="$HOME/.config/wezterm/wezterm.lua"
        mkdir -p "$(dirname "$WEZTERM_DEST")"
        cp -f "$DOTFILES_DIR/wezterm/wezterm.lua" "$WEZTERM_DEST"
        echo "WezTerm config installed to $WEZTERM_DEST"
    fi

    echo "Dotfiles setup complete!"
    echo "Fish config installed to $FISH_DEST"
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
            install_fish
            install_starship
            install_fastfetch
            install_nvm
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