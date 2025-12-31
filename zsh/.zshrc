# Profiling
zmodload zsh/zprof

# Smarter completion initialization
# https://scottspence.com/posts/speeding-up-my-zsh-shell
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# Load work specific configs
source ~/.cloverrc

# Aliases
alias tmux="TERM=screen-256color-bce tmux"
alias be="bundle exec"
alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'
alias ls='ls -G' # Colorizes output

export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files --hidden'

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then
  eval "$(pyenv init --path --no-rehash - zsh)";
  eval "$(pyenv virtualenv-init --no-rehash - zsh)"
fi

# Rbenv
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Enable reverse search
bindkey -e
bindkey '^R' history-incremental-search-backward

# Git Stuff
# https://git-scm.com/book/en/v2/Git-in-Other-Environments-Git-in-Zsh
#
# Enable Git auto complete
autoload -Uz compinit && compinit

# vcs_info was slow on my machine for whatever reason, now just using precmd_git_branch
# Git prompt stuff to display branch
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
# zstyle ':vcs_info:*' check-for-changes false
# zstyle ':vcs_info:git:*' formats '<%b> '

precmd_git_branch() {
     local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
     if [[ -n $branch ]]; then
         GIT_PROMPT="<$branch> "
     else
         GIT_PROMPT=""
     fi
}
precmd_functions+=( precmd_git_branch )
setopt prompt_subst

# See this for setting newline if prompt is too long https://unix.stackexchange.com/a/537248
NEWLINE=$'\n'
PROMPT='[%*] %n %(4~|../%3~|%~) ${GIT_PROMPT}%-30(l::${NEWLINE}> )'

# Will ignore duplicates when going up in history
setopt histignoredups

# Will search in history when pressing up key
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Make the delete key delete a character instead of sending a tilde
bindkey "^[[3~" delete-char

# Sending rg to a pager.
# See https://github.com/BurntSushi/ripgrep/issues/86#issuecomment-425744884
rg() {
  # If outputting (fd 1 = stdout) directly to a terminal, page automatically:
  if [ -t 1 ]; then
    command rg -p "$@" \
      | less --no-init --RAW-CONTROL-CHARS --LONG-PROMPT
  else
    command rg "$@"
  fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export HISTFILE=~/.zsh_history # File to save history to
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

setopt HIST_FIND_NO_DUPS # Skip duplicates when going up and down history
setopt INC_APPEND_HISTORY # Immediately append history to file
setopt EXTENDED_HISTORY # Add timestamp to history in file

export PATH="/Users/alexng/.local/bin:$PATH"

# Profiling
zprof
