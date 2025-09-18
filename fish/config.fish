starship init fish | source

if status is-interactive && type -q fastfetch
    fastfetch
end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
