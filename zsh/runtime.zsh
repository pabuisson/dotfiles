# RBENV
if command -v rbenv > /dev/null
then
  eval "$(rbenv init -)";
fi

# ASDF versions manager
if [[ -e /usr/local/opt/asdf/libexec/asdf.sh ]]
then
  source /usr/local/opt/asdf/libexec/asdf.sh
elif [[ -e $HOME/.asdf/asdf.sh ]]
then
  source $HOME/.asdf/asdf.sh
else
  echo "You might need to install asdf to handle versions"
  echo "$ brew install asdf"
fi
