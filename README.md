# Dotfiles

This repository contains my personal configuration files for **WezTerm** and **Fish shell**, designed to work on Linux, MacOS, and Windows (via WSL).  

It aims to provide a consistent terminal environment across all platforms.

---

## Prerequisites

Before setting up the configuration, make sure you have:

- Git
- [WezTerm](https://wezfurlong.org/wezterm/)
- [Fish shell](https://fishshell.com/)
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

* Starship prompt
* Custom functions and scripts in `~/.config/fish/functions/`
* Additional WezTerm keybindings or colorschemes

---

### 6. Installing the Tide Prompt for Fish

[Tide](https://github.com/IlanCosman/tide) is a fast and minimal Fish shell prompt with Git integration and nice styling. Here's how to install it:

1. **Install dependencies** (Node.js and Fisher):

```bash
# Install Node.js (required for Tide)
# On Linux / MacOS
brew install node        # MacOS
sudo apt install nodejs npm  # Ubuntu/Debian

# Install Fisher (Fish plugin manager)
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

2. **Install Tide**:

```bash
fisher install IlanCosman/tide
```

3. **Configure Tide**:

3a. - Option 1 - Single command to setup tide with my perferences:
```bash
tide configure --auto --style=Rainbow --prompt_colors='16 colors' --show_time='12-hour format' --rainbow_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Compact --icons='Few icons' --transient=Yes
```

3b. - Option 2 - Run the setup wizard:

```bash
tide configure
```

Follow the prompts to select your preferred prompt style, Git integration, colors, and prompt features.

4. **Apply changes**:

Restart Fish or source your config:

```bash
source ~/.config/fish/config.fish
```

Your Fish shell should now show the Tide prompt with your selected configuration.