# Pabe's dotfiles

## Setup in a new environment

```bash
ln -s $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/commonrc $HOME/.commonrc
ln -s $HOME/.dotfiles/gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/nvim $HOME/.config/
ln -s $HOME/.dotfiles/espanso.yml $HOME/Library/Application\ Support/espanso/match/own.yml
```

For Neovim initialization: see installation guidelines on [vim-plug](https://github.com/junegunn/vim-plug) repo and then `:PlugInstall`.


## Dependencies

- `z` for fast directory jump: https://github.com/rupa/z
- `ripgrep` for fast search: https://github.com/BurntSushi/ripgrep
- `asdf`, one version manager to rule them all: https://asdf-vm.com/
- `espanso`, an open-source text-expander: https://espanso.org/

NOTE: `fzf` will come as a dependency of `fzf.vim` so there should be no need to install it separately
