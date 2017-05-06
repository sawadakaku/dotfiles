# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/sawada/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# .zshrc

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
