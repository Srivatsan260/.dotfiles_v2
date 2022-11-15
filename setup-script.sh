#!/usr/bin/env sh

set -e

[ ! -L ~/.config/vim ] && [ ! -e ~/.config/vim ] && ln -s ~/dotfiles/vim ~/.config/vim
[ ! -L ~/.config/nvim ] && [ ! -e ~/.config/nvim ] && ln -s ~/dotfiles/nvim ~/.config/nvim
[ ! -L ~/.config/kitty ] && [ ! -e ~/.config/kitty ] && ln -s ~/dotfiles/kitty ~/.config/kitty
[ ! -L ~/.config/lazygit ] && [ ! -e ~/.config/lazygit ] && ln -s ~/dotfiles/lazygit ~/.config/lazygit
[ ! -L ~/.tmux.conf ] && [ ! -e ~/.tmux.conf ] && ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
[ ! -L ~/.gitignore_global ] && [ ! -e ~/.gitignore_global ] && ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
