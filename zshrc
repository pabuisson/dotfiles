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
# RVM
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# nvm
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


# VIM MODE CURSOR SHAPE

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() {
   echo -ne '\e[5 q'
}

# VIM MODE "NORMAL" EOL INDICATOR
# NOTE: breaks the cursor shape thing

# http://coryklein.com/vi/2015/09/17/a-working-vi-mode-indicator-in-zsh.html
# function zle-line-init zle-keymap-select {
#    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
#    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#    zle reset-prompt
# }
# Conflicts between ZSH and GIT HEAD^ resulting in "no matches found" error
# when trying to use HEAD^ in a git command
setopt NO_NOMATCH

# zle -N zle-line-init
# zle -N zle-keymap-select


# --- RAILS ---
export HTTPS=1
