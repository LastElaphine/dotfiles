# Dotfiles

This repository contains my personal configuration files for a modern terminal environment, designed to work on Linux and MacOS. It aims to provide a consistent and visually appealing terminal experience across both platforms.

## Features

This setup includes:

-   **[WezTerm](https://wezfurlong.org/wezterm/):** A GPU-accelerated cross-platform terminal emulator and multiplexer.
-   **[Starship](https://starship.rs/):** A minimal, blazing-fast, and infinitely customizable prompt for any shell.
-   **[fastfetch](https://github.com/fastfetch-cli/fastfetch):** A neofetch-like tool for fetching system information and displaying them in a pretty way.
-   **[Neovim](https://neovim.io/):** A modern, highly extensible text editor.

## Recommended Font

For the best experience, it is recommended to install the **JetBrains Mono Nerd Font**. You can download it from the [Nerd Fonts website](https://www.nerdfonts.com/font-downloads).

## Prerequisites

Before you begin, ensure you have the following installed:

-   [Git](https://git-scm.com/)
-   [curl](https://curl.se/)
-   [stow](https://www.gnu.org/software/stow/)

## Installation

### 1. Clone the repository

```bash
# Using SSH (recommended)
git clone git@github.com:LastElaphine/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Or using HTTPS
git clone https://github.com/LastElaphine/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Use GNU Stow to create symlinks for each package

E.g.

- `stow nvim` will create a symlink to the correct configuration location for dotfiles for Neovim
