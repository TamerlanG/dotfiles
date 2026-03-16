set fish_greeting

abbr ls 'lsd'
abbr cat 'bat'
alias k='kubectl'


source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# uv
fish_add_path "/Users/tamerlan/.local/bin"

# starship init fish | source
zoxide init fish --cmd cd | source
