set fish_greeting

abbr ls 'lsd'
abbr cat 'bat'
alias k='kubectl'

# Git basics
abbr g 'git'
abbr gs 'git status'
abbr ga 'git add'
abbr gc 'git commit'
abbr gcm 'git commit -m'
abbr gp 'git push'
abbr gl 'git pull'
abbr gf 'git fetch'
abbr glog 'git log --oneline --graph'

# Branching
abbr gco 'git checkout'
abbr gcb 'git checkout -b'
abbr gb 'git branch'
abbr gm 'git merge'
abbr grb 'git rebase'

# Diff & stash
abbr gd 'git diff'
abbr gds 'git diff --staged'
abbr gst 'git stash'
abbr gstp 'git stash pop'

# Remote / fork workflow
abbr gra 'git remote add'
abbr grv 'git remote -v'

# GitHub CLI
abbr ghpr 'gh pr checkout'
abbr ghsync 'gh repo sync'

source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# uv
fish_add_path "/Users/tamerlan/.local/bin"

# starship init fish | source
zoxide init fish --cmd cd | source
