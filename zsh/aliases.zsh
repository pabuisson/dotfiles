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
alias bd="bin/dev"
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
# FIXME: quotes escaping, I guess
alias brewdeps="brew list | while read cask; do echo -n $fg[blue] $cask $fg[white]; brew deps $cask | awk '{printf(\" %s \", $0)}'; echo ''; done"
