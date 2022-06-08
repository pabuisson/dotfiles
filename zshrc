source $HOME/.commonrc

# Completion
autoload -Uz compinit
compinit

# Stack of visited directories
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
alias d='dirs -v'
# Creates indices to quickly access the 10 last directories
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Enabling and setting git info var to be used in prompt config.
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
# This line obtains information from the vcs.
zstyle ':vcs_info:git*' formats "(%b)"
precmd() {
  vcs_info
}

# Enable substitution in the prompt.
setopt prompt_subst

# PROMPT
# 1st part = prefix prompt with number of background jobs if any - https://stackoverflow.com/a/10194174/85076
# 2nd part = user and directory
# 3rd part = git branch
# NOTE: must use single quotes instead of double quotes otherwise git info does not get updated when moving
#       in the filesystem or switching git branch
#       source: https://stackoverflow.com/a/57439606/85076
PS1='%(1j.%F{red}[%j] %f.)%F{cyan}%n%f@%F{blue}%1d%f %F{green}${vcs_info_msg_0_}%f $ '

# # New line before each command
# function precmd { print "" }

# Enable history
export HISTFILESIZE=1000
export HISTSIZE=1000
export HISTFILE=~/.zsh_history
# Ignore duplicates when searching through history
setopt HIST_FIND_NO_DUPS
# Add timestamp to commands
setopt EXTENDED_HISTORY
# Don't wait for shell to close to append to history
setopt INC_APPEND_HISTORY


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

