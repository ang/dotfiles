eval "$(rbenv init -)"

alias tmux="TERM=screen-256color-bce tmux"

export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"
export PATH="$PATH:`yarn global bin`"
eval "$(nodenv init -)"
