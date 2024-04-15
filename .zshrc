# P10k and oh-my-zsh Configuration
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions kubectl zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases 
alias ls='lsd'
alias cat='bat'

# Python 
export PATH="$HOME/.poetry/bin:$PATH"

# Go
export PATH="$HOME/go/bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun" # Bun Completion 

# Dotnet 
export PATH="$PATH:$HOME/.dotnet/tools"

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Starship (Should be at the end of the file)
eval "$(starship init zsh)"

# ASDF 
source $HOME/.asdf/asdf.sh
export PATH=$HOME/.asdf/asdf.sh:$PATH

source <(kubectl-argo-rollouts completion bash)
