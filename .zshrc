HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# completion
autoload -Uz compinit
compinit

# setting alias
# ls (color)
alias ls='ls -G'

# setting prompt
PROMPT='%m:%F{green}%~%f %n$ '
# PROMPT='%m:%F{green}%c%f %n$ '

# history search
# for incremental search
setopt inc_append_history
bindkey "^R" history-incremental-search-backward
