#!/bin/bash

set -ex

# Maybe use stow (https://www.gnu.org/software/stow/) ?
ln -sf ~/.dotfiles/Brewfile ~/Brewfile
ln -sf ~/.dotfiles/.ideavimrc ~/.ideavimrc
ln -sf ~/.dotfiles/xdg_config/* ~/.config/

brew bundle
./install.sh
source ./xdg_config/fish/functions/fisher.fish # fish package manager (https://github.com/jorgebucaran/fisher)
fisher install jorgebucaran/fisher
./macos/setup.sh

bat cache --build
