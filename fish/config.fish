starship init fish | source

if type -q nvm
    nvm use latest > /dev/null 2>&1
end

if type -q fastfetch
    fastfetch
end