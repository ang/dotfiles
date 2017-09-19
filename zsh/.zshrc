eval "$(rbenv init -)"

# Aliases
alias tmux="TERM=screen-256color-bce tmux"
alias be="bundle exec"
alias ag='ag --pager="less -R"'
alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'

export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"

# Enable reverse search
bindkey -e
bindkey '^R' history-incremental-search-backward

# Git Stuff
# https://git-scm.com/book/en/v2/Git-in-Other-Environments-Git-in-Zsh
#
# Enable Git auto complete
autoload -Uz compinit && compinit

# Git prompt stuff to display branch
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '<%b>: '

PROMPT='[%*] %n %(4~|../%3~|%~) '\$vcs_info_msg_0_

# Will ignore duplicates when going up in history
setopt histignoredups

# Will search in history when pressing up key
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Have mysql 5.6 linked to the path
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# Make the delete key delete a character instead of sending a tilde
bindkey "^[[3~" delete-char

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
