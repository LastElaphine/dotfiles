# Dotfiles

This repository contains my personal configuration files for **WezTerm** and **Fish shell**, designed to work on Linux, MacOS, and Windows (via WSL).  

It aims to provide a consistent terminal environment across all platforms.

---

## Prerequisites

Before setting up the configuration, make sure you have:

- Git
- [WezTerm](https://wezfurlong.org/wezterm/)
- [Fish shell](https://fishshell.com/)
- [NVM](https://github.com/nvm-sh/nvm)
- [Bass](https://github.com/edc/bass) is a small utility that lets Fish shell execute **Bash-style scripts** that modify the environment (like `nvm` or `pyenv`). It captures environment variable changes from Bash and applies them in Fish.
- (Optional) Homebrew on MacOS or Scoop/Chocolatey on Windows

---

## Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/LastElaphine/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

---

### 2. WezTerm Configuration

1. Copy the platform-specific WezTerm configuration:

```bash
# Linux / MacOS
mkdir -p ~/.config/wezterm
cp wezterm/wezterm.lua ~/.config/wezterm/

# Windows (native)
mkdir -p $env:LOCALAPPDATA\wezterm
cp wezterm/wezterm-win.lua $env:LOCALAPPDATA\wezterm\wezterm.lua
```

2. Restart WezTerm to load the new configuration.

> Both `wezterm` and `wezterm-win` folders exist to separate Linux/MacOS vs Windows configs.

---

### 3. Fish Shell Configuration

1. Install Fish 4:

#### Linux (Ubuntu/Debian example)

```bash
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:fish-shell/release-4
sudo apt update
sudo apt install -y fish
```

#### MacOS

```bash
brew install fish
```

#### Windows (WSL)

Install Fish in your WSL distro.

#### Windows (native)

```bash
scoop install fish
# or
choco install fish
```

2. Set Fish as your default shell (optional):

```bash
which fish | sudo tee -a /etc/shells
chsh -s (which fish)
```

3. Copy the Fish configuration:

```bash
mkdir -p ~/.config/fish
cp config.fish ~/.config/fish/
```

4. Restart your terminal to load the new configuration.

---

### 4. Notes

* The Fish config sets aliases, environment variables, and optionally starts `ssh-agent`.
* WezTerm config is platform-specific; use the correct file for your OS.
* For cross-platform setups, check `$os` in Fish or use conditional statements in `wezterm.lua`.

---

### 5. Optional: Extend Your Setup

You can add:

* Custom functions and scripts in `~/.config/fish/functions/`
* Additional WezTerm keybindings or colorschemes

---

### 6. Install Bass

```bash
fisher install edc/bass
```

---

### 7. Install Starship

[Starship](https://starship.rs/) is a minimal, blazing-fast, and infinitely customizable prompt for any shell!

1. **Install Starship**

```bash
curl -sS https://starship.rs/install.sh | sh
```

2. **Configure Starship**

To configure starship you need to create a `starship.toml` file in `~/.config/`.

You can find more information about personalizing starship at the [official docs](https://starship.rs/config/)

---

### 8. Install fastfetch

[fastfetch](https://github.com/fastfetch-cli/fastfetch) is a neofetch-like tool for fetching system information and displaying them in a pretty way.

#### Linux

<details>
<summary>Arch Linux</summary>

```bash
sudo pacman -S fastfetch
```

</details>

<details>
<summary>Fedora</summary>

```bash
sudo dnf install fastfetch
```

</details>

<details>
<summary>Ubuntu</summary>

```bash
sudo add-apt-repository ppa:fastfetch-cli/fastfetch
sudo apt update
sudo apt install fastfetch
```

</details>

#### MacOS

```bash
brew install fastfetch
```

#### Windows

```bash
scoop install fastfetch
# or
choco install fastfetch
```