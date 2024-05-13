# Pabe's dotfiles

## Setup in a new environment

```bash
ln -s $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/commonrc $HOME/.commonrc
ln -s $HOME/.dotfiles/gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/nvim $HOME/.config/nvim
```

For Neovim initialization: https://github.com/junegunn/vim-plug && `:PlugInstall`

## Dependencies

- `z` for fast directory jump: https://github.com/rupa/z
- `ripgrep` for fast search: https://github.com/BurntSushi/ripgrep
- `asdf`, one version manager to rule them all: https://asdf-vm.com/
