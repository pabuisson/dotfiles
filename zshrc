#
# EXECUTES COMMANDS AT THE START OF AN INTERACTIVE SESSION.
#

# SOURCE PREZTO.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# Source my common config file
source ~/.commonrc


# New line before each command
function precmd { print "" }


# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"




export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
