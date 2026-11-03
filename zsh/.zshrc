# Sourced from ~/.zshrc (created by install.sh). Put machine-local and private
# settings in ~/.zshrc itself, below the `source` line.

# zmodload zsh/zprof

#  ╒══════════════════════════════════════════════════════════╕
#  │                         Language                         │
#  ╘══════════════════════════════════════════════════════════╛
# PATH is set in ~/.zprofile (Homebrew, cargo, uv, mise shims, go).

# mise: Node.js / Java / Ruby / Scala / sbt / Bazelisk
command -v mise >/dev/null && eval "$(mise activate zsh)"

#  ╒══════════════════════════════════════════════════════════╕
#  │                         Options                          │
#  ╘══════════════════════════════════════════════════════════╛

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e

setopt ignore_eof          # avoid loged-out with ctrl-d
setopt print_eight_bit
setopt auto_cd
setopt auto_pushd
setopt correct
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
setopt magic_equal_subst
setopt nobeep
setopt nolistbeep
setopt numeric_glob_sort
setopt list_packed
setopt list_types

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


#  ╒══════════════════════════════════════════════════════════╕
#  │                          Alias                           │
#  ╘══════════════════════════════════════════════════════════╛

alias ls='eza --group-directories-first'
alias lsa='eza -Tla -L1'


#  ╒══════════════════════════════════════════════════════════╕
#  │                        Functions                         │
#  ╘══════════════════════════════════════════════════════════╛

# fzf-based functions live in fzf.zsh

p() {
  python3 -c "s = $*; print(s)"
}

idea() {
#     command idea "$@" > /dev/null 2>&1 &
    open -na "IntelliJ IDEA.app" --args "$@"
}

#  ╒══════════════════════════════════════════════════════════╕
#  │                         Plugins                          │
#  ╘══════════════════════════════════════════════════════════╛

#  ┍━━━━━━━━┑
#  │ zoxide │
#  ┕━━━━━━━━┙
# z <keyword>: jump to a frequently visited directory, zi: select with fzf
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

#  ┍━━━━━┑
#  │ FZF │  settings and fzf-based functions (c, fgc, flog, fadd, fvim, Ctrl-Z, ...)
#  ┕━━━━━┙
source "${${(%):-%x}:A:h}/fzf.zsh"

#  ┍━━━━━━━━━┑
#  │ Plugins │  installed with Homebrew (see Brewfile)
#  ┕━━━━━━━━━┙
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $HOMEBREW_PREFIX/share/zsh-completions $fpath)

# pure prompt
autoload -Uz promptinit && promptinit
prompt pure
# pure escapes `%` in PURE_PROMPT_SYMBOL, so inject the multi-colored symbol into the prompt directly
_pure_symbol='%B%F{1}❯%F{3}❯%F{2}❯%f%b'
PROMPT=${PROMPT//'${prompt_pure_state[prompt]}'/$_pure_symbol}
PROMPT2=${PROMPT2//'${prompt_pure_state[prompt]}'/$_pure_symbol}
unset _pure_symbol

_zsh_plugin=$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f $_zsh_plugin ]] && source $_zsh_plugin
unset _zsh_plugin

# Completions

# Generated completions are cached and regenerated only when the binary is updated
_zcomp_cache=$HOME/.cache/zsh/completions
[[ -d $_zcomp_cache ]] || mkdir -p $_zcomp_cache
fpath=($_zcomp_cache $fpath)
if (( $+commands[uv] )) && [[ ! -s $_zcomp_cache/_uv || $commands[uv] -nt $_zcomp_cache/_uv ]]; then
  uv generate-shell-completion zsh >| $_zcomp_cache/_uv
  uvx --generate-shell-completion zsh >| $_zcomp_cache/_uvx
fi
unset _zcomp_cache

# Full security check only once a day; otherwise use the cached dump
autoload -Uz compinit
_zcompdump_stale=(~/.zcompdump(N.mh+24))
if (( $#_zcompdump_stale )) || [[ ! -f ~/.zcompdump ]]; then
  compinit
else
  compinit -C
fi
unset _zcompdump_stale

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi

# zsh-syntax-highlighting must be sourced after all other widgets are defined
_zsh_plugin=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f $_zsh_plugin ]] && source $_zsh_plugin
unset _zsh_plugin
