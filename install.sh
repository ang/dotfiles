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

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install zsh
brew install zsh
# Set zsh as default shell
ZSH_SHELL="$(grep zsh /etc/shells -m 1)"
chsh -s $ZSH_SHELL

# TODO Backup files before symlinking, you can't symlink files if they already
# exist.

# link bash profile and bashrc
ln -s "$DOTFILES_DIR"/zsh/.zshrc .zshrc
