#!/bin/bash

set -ex

# Maybe use stow (https://www.gnu.org/software/stow/) ?
ln -sf ~/.dotfiles/Brewfile ~/Brewfile
ln -sf ~/.dotfiles/.ideavimrc ~/.ideavimrc
ln -sf ~/.dotfiles/xdg_config/* ~/.config/

brew bundle

./macos/setup.sh

bat cache --build
