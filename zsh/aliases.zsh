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
alias gca='git commit -a'
alias gap='git add -p'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch -p'
alias gp='git pull -p'
alias gpr='git pull -p --rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gst='git st'
alias gmb='git merge-base'
alias gitconflict='$EDITOR $(git diff --name-only --diff-filter=U | xargs)'
# Churn on past 6 months (number of commits per file)
alias gitchurn="git log --all -M -C --name-only --format='format:' $@ --since='6 months ago' | sort | grep -v '^$' | uniq -c | sort -n | tail -10"
# Get short SHA1 of HEAD in clipboard
alias githead='git rev-parse HEAD | cut -c 1-8 | pbcopy'

# Set of aliases involving a reference branch name
# TODO: improve the prompt: maybe show last committer and last commit date
#       check https://chatgpt.com/c/ef296795-b4b7-42aa-a804-a1cff334b526
alias gbdm="git branch --format='%(refname:short)' --merged | grep -v 'master\|develop' | xargs -p -n 1 git branch -d"
alias gsm='git switch master'
alias gsd='git switch develop'
alias gsfm='git switch -f master'
alias gsfd='git switch -f develop'
alias grom='git rebase origin/master'
alias grod='git rebase origin/develop'
# Single quotes needed here, or what's inside subcommands get evaluated everytime (even when
# initializing the shell and reading those aliases, which gives me errors 'not in a git repo')
# NOTE: https://git-scm.com/docs/git-diff#Documentation/git-diff.txt---diff-filterACDMRTUXB82308203
alias gdm='git diff $(git merge-base head origin/master)'
alias gdd='git diff $(git merge-base head origin/develop)'
alias gfm='$EDITOR $(git diff --name-only --diff-filter=ACMRT origin/master... | xargs)'
alias gfd='$EDITOR $(git diff --name-only --diff-filter=ACMRT origin/develop... | xargs)'
alias gfl='$EDITOR $(git diff --name-only --diff-filter=ACMRT head | xargs)'

# RAILS / RUBY
alias ru="rackup"
alias be="bundle exec"
alias mm="bundle exec middleman"
alias rt="rails t"
alias rs="bundle exec bin/rails server || bundle exec rails server"
alias rc="bundle exec bin/rails console || bundle exec rails console"
alias rdbms="bundle exec rails db:migrate:status"
alias rdbm="bundle exec rails db:migrate"
alias rdbr="bundle exec rails db:rollback"
alias rdbs="bundle exec rails db:seed"
alias bd="bin/dev"
# JAVASCRIPT
alias nrt="npm run test"
# RSPEC
alias rsa="bundle exec rspec"
alias rss="bundle exec rspec spec/serializers"
alias rsc="bundle exec rspec spec/controllers"
alias rsm="bundle exec rspec spec/models"
# DOCKER
alias dc="docker compose"
# PACKAGES
alias brewleaves="brew leaves --installed-on-request | xargs -n1 brew desc --eval-all"
# ELIXIR
alias mdg="mix deps.get"
alias mt="mix test"
alias mtt="mix test --trace"
alias mtw="mix test.watch"
alias mps="iex -S mix phx.server"
alias mpr="mix phx.routes"
alias mc="iex -S mix"
alias mcp="mix compile"
alias mtmod="mt $(git diff --name-only --diff-filter=ACMRT head | grep '_test.exs' | xargs)"
alias mttmod="mtt $(git diff --name-only --diff-filter=ACMRT head | grep '_test.exs' | xargs)"
