source $HOME/.commonrc

if [[ -e $HOME/.workrc ]]
then
  source $HOME/.workrc
fi

# ----- ZSH CONFIGURATION -----

# COMPLETION
autoload -Uz compinit
# Don't error or list possibilities on ambiguous pattern, but insert the 1st option, then the 2nd, etc
# Without this, I'd need another <TAB> press to get this
setopt MENU_COMPLETE
# Highlights each suggestion one by one instead of just completing the prompt
zstyle ':completion:*' menu select
# Tries case insensitive option if case sensitive does not matche
# And matching can occur on both side of the word (ie. in the middle of filenames)
# source: https://zsh.sourceforge.io/Doc/Release/Completion-System.html
# source: https://stackoverflow.com/a/22627273/85076
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
compinit


# VIM MODE
# https://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1
bindkey -v

VI_NORMAL_MODE_CHAR='◼︎'
VI_INSERT_MODE_CHAR='▶'
PROMPT_CHAR=

# Change cursor shape for different vi modes
# And sets the PROMPT_CHAR variable accordingly
function zle-keymap-select () {
  case $KEYMAP in
    vicmd)
      echo -ne '\e[1 q' # block
      PROMPT_CHAR="%F{grey}$VI_NORMAL_MODE_CHAR%f"
      ;;
    viins|main)
      echo -ne '\e[5 q' # beam
      PROMPT_CHAR="%F{yellow}$VI_INSERT_MODE_CHAR%f"
      ;;
  esac
  zle reset-prompt
}

# initiate vi insert as keymap and display "beam" characters as cursor
zle-line-init(){
  zle -K viins
  echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for new prompts

zle -N zle-keymap-select


# STACK OF VISITED DIRECTORIES
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
alias d='dirs -v'
# Creates indices to quickly access the 10 last directories
for index ({1..9}) alias "$index"="cd +${index}"; unset index


# PROMPT
# Enabling and setting git info var to be used in prompt config.
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true

# formats: list of formats used when actionformats is not used (which is most of the time)
zstyle ':vcs_info:git*' formats ' (%b)%u'
# actionformats: list of formats used if there is a special action going on in current repository (interactive rebase, merge conflict)
zstyle ':vcs_info:git*' actionformats ' (%b) [%a]%u'
zstyle ':vcs_info:git*' unstagedstr " %F{red}✖︎%f"
# TODO: unpushed commits can be obtained through "git lg @{push}..". Add this to the prompt
precmd() {
  vcs_info
}

# Enable substitution in the prompt.
setopt PROMPT_SUBST

# 2nd part = user and directory
# 3rd part = git branch
# NOTE: single quotes mandatory so that git info is updated when moving in the FS or switching branch
#       source: https://stackoverflow.com/a/57439606/85076
# %F{color} starts the color, %f stops it
# %B starts bold, %b stops it
NEWLINE=$'\n'
# Number of background jobs if any - https://stackoverflow.com/a/10194174/85076
BACKGROUND_JOBS='%(1j.%F{red}[%j] %f.)'
# INVITE=insert_mode
PS1='$NEWLINE%B$BACKGROUND_JOBS%F{cyan}%n%f@%F{blue}%1d%f%F{green}${vcs_info_msg_0_}%f%b ${PROMPT_CHAR} '



# HISTORY
export HISTFILESIZE=1000
export HISTSIZE=1000
export HISTFILE=~/.zsh_history
# Ignore duplicates when searching through history
setopt HIST_FIND_NO_DUPS
# Don't write duplicates to history
setopt HIST_IGNORE_ALL_DUPS
# Add timestamp to commands
setopt EXTENDED_HISTORY
# Don't wait for shell to close to append to history
setopt INC_APPEND_HISTORY
bindkey '^R' history-incremental-search-backward
# Using this, to make sure the HIST_FIND_NO_DUPS settings is used for up and down keys too
bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history

# OTHER SETTINGS
# Conflicts between ZSH and GIT HEAD^ resulting in "no matches found" error
# when trying to use HEAD^ in a git command
setopt NO_NOMATCH


# CD-ING
# Typing a directory without "cd" does cd to the directory
setopt AUTO_CD
# ----- SOURCING MORE CONFIG FILES -----

source "$HOME/.dotfiles/zsh/runtime.zsh"
source "$HOME/.dotfiles/zsh/aliases.zsh"
source "$HOME/.dotfiles/zsh/dependencies.zsh"


# ----- OTHER SETTINGS -----

export BAT_THEME="ansi"
