# Dotfiles

This repository contains my personal configuration files for a modern terminal environment, designed to work on Linux and MacOS. It aims to provide a consistent and visually appealing terminal experience across both platforms.

## Features

This setup includes:

-   **[WezTerm](https://wezfurlong.org/wezterm/):** A GPU-accelerated cross-platform terminal emulator and multiplexer.
-   **[Fish Shell](https://fishshell.com/):** A smart and user-friendly command-line shell.
-   **[Starship](https://starship.rs/):** A minimal, blazing-fast, and infinitely customizable prompt for any shell.
-   **[fastfetch](https://github.com/fastfetch-cli/fastfetch):** A neofetch-like tool for fetching system information and displaying them in a pretty way.
-   **[mise](https://github.com/jdx/mise):** A fast and reliable version manager for multiple languages.
-   **[Fisher](https://github.com/jorgebucaran/fisher):** A plugin manager for the fish shell.
-   **[Neovim](https://neovim.io/):** A modern, highly extensible text editor.

## Recommended Font

For the best experience, it is recommended to install the **JetBrains Mono Nerd Font**. You can download it from the [Nerd Fonts website](https://www.nerdfonts.com/font-downloads).

## Prerequisites

Before you begin, ensure you have the following installed:

-   [Git](https://git-scm.com/)
-   [curl](https://curl.se/)

## Installation

This repository includes an `install.sh` script to automate the setup process.

### 1. Clone the repository

```bash
# Using SSH (recommended)
git clone git@github.com:LastElaphine/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Or using HTTPS
git clone https://github.com/LastElaphine/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Run the installation script

The script provides two main options:

-   `--full-install`: Installs all the tools (fish, starship, fisher, mise, neovim) and sets up the dotfiles.
-   `--setup-dotfiles`: Only sets up the dotfiles, assuming you have the necessary tools installed.

Choose the option that best suits your needs.

#### Full Installation

This option will install all the necessary tools and set up the dotfiles.

```bash
./install.sh --full-install
```

#### Setup Dotfiles Only

If you already have `fish`, `starship`, `fisher`, `mise`, and `neovim` installed, you can use this option to only set up the dotfiles.

```bash
./install.sh --setup-dotfiles
```

### Help

To see the available options, use the `--help` flag.

```bash
./install.sh --help
```

## Manual Installation

If you prefer to install the dotfiles manually, you can look at the `install.sh` script to see the steps involved. The script is well-commented and should be easy to follow.

## Customization

You can easily extend this configuration by:

-   Adding new functions to the `fish/functions` directory.
-   Modifying the `wezterm/wezterm.lua` file to change the terminal appearance and behavior.
-   Customizing the `starship.toml` file to change your prompt.
-   Updating the `mise/config.toml` file to manage your development tools and environments.
-   Modifying the `nvim` directory to customize your Neovim configuration.
