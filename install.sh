#!/bin/bash

# -e: Exit if there are errors
# -x: Print a trace of simple commands
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
set -e -x

# Get curent working directory
# dirname "$0" will get the name of the directory
# cd into that directory
# Then print out the directory
DOTFILES_DIR="$(cd "$(dirname "$0")"; pwd -P)"

# TODO Backup files before symlinking, you can't symlink files if they already
# exist.

# link bash profile and bashrc
ln -s "$DOTFILES_DIR"/bash/.bashrc .bashrc
ln -s "$DOTFILES_DIR"/bash/.bash_profile .bash_profile
