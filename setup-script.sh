#!/usr/bin/env sh

set -e

[ ! -L ~/.vimrc ] && [ ! -e ~/.vimrc ] && ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
[ ! -L ~/.config/nvim ] && [ ! -e ~/.config/nvim ] && ln -s ~/dotfiles/nvim ~/.config/nvim
[ ! -L ~/.config/wezterm ] && [ ! -e ~/.config/wezterm ] && ln -s ~/dotfiles/wezterm ~/.config/wezterm
[ ! -L ~/.config/lazygit ] && [ ! -e ~/.config/lazygit ] && ln -s ~/dotfiles/lazygit ~/.config/lazygit
[ ! -L ~/.tmux.conf ] && [ ! -e ~/.tmux.conf ] && ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
[ ! -L ~/.gitignore_global ] && [ ! -e ~/.gitignore_global ] && ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
