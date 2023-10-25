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
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install zsh
brew install zsh
# Look for where zsh is installed, use -m 1 to grab the first line that matches
ZSH_SHELL="$(grep zsh /etc/shells -m 1)"
# Set zsh as default shell
chsh -s $ZSH_SHELL

# Install neovim
brew tap neovim/neovim
brew install neovim
# Install vim-plug, vim plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

brew install ripgrep

brew install tmux

brew install tldr

# Symlink configuration files
ln -sf "$DOTFILES_DIR"/zsh/.zshrc ~/.zshrc
# Create this directory first if it doesn't exist
mkdir -p ~/.config/nvim
ln -sf "$DOTFILES_DIR"/neovim/init.vim ~/.config/nvim/init.vim
mkdir -p ~/.config/nvim/autoload/
ln -sf "$DOTFILES_DIR"/neovim/autoload/* ~/.config/nvim/autoload/
ln -sf "$DOTFILES_DIR"/tmux/.tmux.conf ~/.tmux.conf
