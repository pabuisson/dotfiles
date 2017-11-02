#
# EXECUTES COMMANDS AT THE START OF AN INTERACTIVE SESSION.
#

# Source my common config file
source ~/.commonrc

# zsh rebind search to ctrl-R for vi-mode
bindkey '^R' history-incremental-search-backward
# bind a custom escape code from iterm2 to backward search
bindkey '^[search' history-incremental-search-backward


# New line before each command
function precmd { print "" }


# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
