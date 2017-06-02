#!/bin/bash

# -e: Exit if there are errors
# -x: Print a trace of simple commands
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
set -e -x

# Get the curent working directory
# dirname "$0" will get the name of the directory
# cd into that directory
# Then print out the directory
DOTFILES_DIR="$(cd "$(dirname "$0")"; pwd -P)"

# TODO, add non OSX, macOS support
if [ "$(uname)" != "Darwin" ]; then # Darwin is the name of the OS!
  echo "Only macOS is currently supported!"
  exit 1
fi

# Install homebrew, see https://brew.sh/
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install zsh
brew install zsh
# Look for where zsh is installed, use -m 1 to grab the first line that matches
ZSH_SHELL="$(grep zsh /etc/shells -m 1)"
# Set zsh as default shell
chsh -s $ZSH_SHELL

# Install neovim
brew tap neovim/neovim
brew install neovim/neovim/neovim
# Install vim-plug, vim plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install ag, the silver searcher
brew install ag

# TODO Backup files before symlinking, you can't symlink files if they already
# exist.
# Symlink configuration files
ln -s "$DOTFILES_DIR"/zsh/.zshrc ~/.zshrc
ln -s "$DOTFILES_DIR"/neovim/init.vim ~/.config/nvim/init.vim
mkdir -p ~/.config/nvim/autoload/
ln -s "$DOTFILES_DIR"/neovim/autoload/* ~/.config/nvim/autoload/
