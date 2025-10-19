set fish_greeting ""

starship init fish | source

if status is-interactive && type -q fastfetch
    fastfetch
end

# Initialize Homebrew
if test -f /home/linuxbrew/.linuxbrew/bin/brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else if test -f /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
else if test -f /usr/local/bin/brew
    eval "$(/usr/local/bin/brew shellenv)"
end

# Aliases
alias ll="ls -alF"
alias l="ls -CF"
alias la="ls -A"
alias lg="lazygit"
alias g="git"
alias v="nvim"

# Abbreviations
abbr gco "git checkout"
abbr gcm "git checkout main"
abbr gps "git push"
abbr gpl "git pull"

# Initialize mise
if test -f $HOME/.local/bin/mise
    $HOME/.local/bin/mise activate fish | source
else if command -v mise >/dev/null
    mise activate fish | source
end
