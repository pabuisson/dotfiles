# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh


# --- USER CONFIGURATION ---

source $HOME/.commonrc

# New line before each command
function precmd { print "" }

# RBENV
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# NVM
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"

if [[ -f ~/.fzf.zsh ]]
then
  # Source FZF
  source ~/.fzf.zsh
  # bind a custom escape code from iterm2 to backward search, using fzf history widget
  # TODO: make sure fzf is available
  bindkey '^[search' fzf-history-widget
else
  echo "You might want to install FZF"
fi

# https://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1
bindkey -v

# Conflicts between ZSH and GIT HEAD^ resulting in "no matches found" error
# when trying to use HEAD^ in a git command
setopt NO_NOMATCH

# Prefix prompt with number of background jobs if any
# https://stackoverflow.com/a/10194174/85076
export PROMPT="%(1j.%{$fg[yellow]%}[%j]%{$reset_color%}.) $PROMPT"
