# Path to your oh-my-zsh installation.
export ZSH="/Users/pierreadrienbuisson/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git)

source $ZSH/oh-my-zsh.sh


# --- USER CONFIGURATION ---

source .commonrc

# New line before each command
function precmd { print "" }

# RBENV
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# RVM
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# nvm
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"

# Source FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bind a custom escape code from iterm2 to backward search, using fzf history widget
# TODO: make sure fzf is available
bindkey '^[search' fzf-history-widget

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
