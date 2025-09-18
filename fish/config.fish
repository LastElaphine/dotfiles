starship init fish | source

if status is-interactive && type -q fastfetch
    fastfetch
end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

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

$HOME/.local/bin/mise activate fish | source
