if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

abbr ls 'lsd'
abbr cat 'bat'

starship init fish | source


# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
