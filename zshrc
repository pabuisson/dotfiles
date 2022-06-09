source $HOME/.commonrc

# ----- ZSH CONFIGURATION -----

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
# ----- ALIASES -----

export EDITOR=nvim

alias ls="ls -G"
alias lsa="ls -a"
alias ll="ls -lh"
alias l="ll"
alias lla="ls -alh"
alias grep="grep --colour"
alias tigs="tig status"
alias n="nvim"

alias currentweek="date +%V"
alias monip="ifconfig | grep 192 | cut -d' ' -f2"

# GIT
alias git='LANG=en_GB git'
alias g='git'
alias gd='git diff'
alias gf='git fetch -p'
alias gp='git pull -p'
alias gpr='git pull -p --rebase'
alias gsm='git sw master'
alias gsfm='git co -f master'
alias grom='git rebase origin/master'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gst='git st'
# Single quotes needed here, or what's inside subcommands get evaluated everytime (even when
# initializing the shell and reading those aliases, which gives me errors 'not in a git repo')
alias gitconflict='$EDITOR $(git status | grep both | cut -d ':' -f 2 | xargs)'
alias giteditedfrommaster='$EDITOR $(git diff --name-only origin/master... | xargs)'
alias giteditedfromlast='$EDITOR $(git diff --name-only head | xargs)'
alias gitdifffrommaster='git diff $(git merge-base head origin/master)'
alias editpimfiles='$EDITOR $(find $(cat CODEOWNERS | grep @doctolib/pims | cut -d " " -f1 | xargs) -iname "*rb")'
alias edittestfiles='$EDITOR $(find $(cat CODEOWNERS | grep test/ | grep @doctolib/pims | cut -d " " -f1 | xargs) -iname "*rb")'
# Churn sur les 6 derniers mois (nombre de commits par fichier)
alias gitchurn="git log --all -M -C --name-only --format='format:' $@ --since='6 months ago' | sort | grep -v '^$' | uniq -c | sort -n | tail -10"
# Get short SHA1 of HEAD in clipboard
alias githead='git rev-parse HEAD | cut -c 1-8 | pbcopy'

# RAILS / RUBY
alias ru="rackup"
alias be="bundle exec"
alias mm="middleman"
alias rt="rails t"
alias rs="bundle exec bin/rails server || bundle exec rails server"
alias rc="bundle exec bin/rails console || bundle exec rails console"
alias rdbms="bundle exec rails db:migrate:status"
alias rdbm="bundle exec rails db:migrate"
alias rdbr="bundle exec rails db:rollback"
alias rdbs="bundle exec rails db:seed"
# RSPEC
alias rsa="bundle exec rspec"
alias rss="bundle exec rspec spec/serializers"
alias rsc="bundle exec rspec spec/controllers"
alias rsm="bundle exec rspec spec/models"
# HANAMI
alias hs="bundle exec hanami server"
alias hc="bundle exec hanami console"
# DOCKER
alias dc="docker compose"
# DOCTO
alias bg="./bin/green.sh"

# FIXME: quotes escaping, I guess
alias brewdeps="brew list | while read cask; do echo -n $fg[blue] $cask $fg[white]; brew deps $cask | awk '{printf(\" %s \", $0)}'; echo ''; done"


# ----- DEPENDENCIES INSTALLATION -----

# Ripgrep for FZF
if type rg &> /dev/null
then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'
else
  echo "You might want to install rg for quick search"
  echo "$ brew install ripgrep"
fi

# https://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1
bindkey -v

# Conflicts between ZSH and GIT HEAD^ resulting in "no matches found" error
# when trying to use HEAD^ in a git command
setopt NO_NOMATCH
# Z instead of FASD
if [[ -e /usr/local/etc/profile.d/z.sh ]]
then
  source /usr/local/etc/profile.d/z.sh
elif [[ -e /opt/homebrew/etc/profile.d/z.sh ]]
then
  source /opt/homebrew/etc/profile.d/z.sh
else
  echo "You might need to install Z for quick-jump"
  echo "$ brew install z"
fi

# # ASDF versions manager
# if [[ -e /usr/local/opt/asdf/asdf.sh ]]
# then
#   source /usr/local/opt/asdf/asdf.sh
# else
#   echo "You might need to install asdf to handle versions"
#   echo "$ brew install asdf"
# fi

# if [[ -f ~/.fzf.zsh ]]
# then
#   source ~/.fzf.zsh
#   # bind a custom escape code from iterm2 to backward search, using fzf history widget
#   # TODO: make sure fzf is available
#   bindkey '^[search' fzf-history-widget
# else
#   echo "You might want to install FZF"
# fi
