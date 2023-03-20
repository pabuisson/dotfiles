# RBENV
if command -v rbenv > /dev/null
then
  eval "$(rbenv init -)";
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if command -v nvm > /dev/null
then
  # Automatically switch to .nvmrc version when entering a directory
  # source: https://github.com/nvm-sh/nvm#calling-nvm-use-automatically-in-a-directory-with-a-nvmrc-file
  autoload -U add-zsh-hook
  load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]
      then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]
      then
        nvm use
      fi
    elif [ "$node_version" != "$(nvm version default)" ]
    then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

# ASDF versions manager
if [[ -e /usr/local/opt/asdf/libexec/asdf.sh ]]
then
  source /usr/local/opt/asdf/libexec/asdf.sh
else
  echo "You might need to install asdf to handle versions"
  echo "$ brew install asdf"
fi
