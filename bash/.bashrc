# .bashrc is executed for interactive non login shells (when you're already
# logged in).
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html

eval "$(rbenv init -)"

alias tmux="TERM=screen-256color-bce tmux"

export VISUAL=nvim
export EDITOR="$VISUAL"
