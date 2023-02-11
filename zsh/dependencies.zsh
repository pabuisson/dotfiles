# Ripgrep for FZF
if type rg &> /dev/null
then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'
else
  echo "You might want to install rg for quick search"
  echo "$ brew install ripgrep"
fi

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
