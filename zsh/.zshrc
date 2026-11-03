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

# c - browse chrome history
c() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Profile 1/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

# fgc (git checkout) - checkout git branch including remote branches
# ref: https://qiita.com/kamykn/items/aa9920f07487559c0c7e
fgc() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" )
}

# flog - git commit browser
# ref: https://qiita.com/kamykn/items/aa9920f07487559c0c7e
flog() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(#C0C0C0)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
              (grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
              {}
              FZF-EOF
             "
}

# fd - cd to selected directory
# https://qiita.com/kamykn/items/aa9920f07487559c0c7e
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fadd: git add / diff をインタラクティブに．Ctrl-d で diff, Enter で add
# https://qiita.com/reviry/items/e798da034955c2af84c5
fadd() {
  local out q n addfiles
  while out=$(
      git status --short |
      awk '{if (substr($0,2,1) !~ / /) print $2}' |
      fzf --multi --exit-0 --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$addfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      # git diff --color=always $addfiles | less -R
      git difftool $addfiles
    else
      git add $addfiles
    fi
  done
}

# fvim: ファイル名検索+Vimで開くファイルをカレントディレクトリからfzfで検索可能に
# ref: https://momozo.tech/2021/03/10/fzf%E3%81%A7zsh%E3%82%BF%E3%83%BC%E3%83%9F%E3%83%8A%E3%83%AB%E4%BD%9C%E6%A5%AD%E3%82%92%E5%8A%B9%E7%8E%87%E5%8C%96/
fvim() {
  local file
  file=$(
         rg --files --hidden --follow --glob "!**/.git/*" | fzf \
             --preview 'bat  --color=always --style=header,grid {}' --preview-window=right:60%
     )
  nvim "$file"
}
alias fv="fvim"

# かつていたことのあるディレクトリに移動する (Ctrl-Z, zoxide の履歴をスコア順に表示)
fzf-z-search() {
    local res=$(zoxide query -l | fzf --no-sort)
    if [ -n "$res" ]; then
        BUFFER="cd ${(q)res}"
        zle accept-line
    else
        zle reset-prompt
    fi
}

zle -N fzf-z-search
bindkey '^z' fzf-z-search


# プロセスをkill
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fzfでdockerコンテナに入る
# ref: https://momozo.tech/2021/03/10/fzf%E3%81%A7zsh%E3%82%BF%E3%83%BC%E3%83%9F%E3%83%8A%E3%83%AB%E4%BD%9C%E6%A5%AD%E3%82%92%E5%8A%B9%E7%8E%87%E5%8C%96/
fdcnte() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker exec -it "$cid" /bin/bash
}

# fzfでdockerのログを取得
# ref: https://momozo.tech/2021/03/10/fzf%E3%81%A7zsh%E3%82%BF%E3%83%BC%E3%83%9F%E3%83%8A%E3%83%AB%E4%BD%9C%E6%A5%AD%E3%82%92%E5%8A%B9%E7%8E%87%E5%8C%96/
fdl() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker logs -f --tail=200 "$cid"
}

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
#  │ FZF │
#  ┕━━━━━┙
# Key bindings (Ctrl-T / Ctrl-R / Alt-C) and completion
command -v fzf >/dev/null && source <(fzf --zsh)

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!**/.git/*"'
export FZF_DEFAULT_OPTS="
    --height 40% --reverse --border=sharp --margin=0,1
    --prompt='"$''" ' --color=light
"

# for finding files in current directories
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!**/.git/*"'
export FZF_CTRL_T_OPTS="
    --preview 'bat  --color=always --style=header,grid {}'
    --preview-window=right:60%
"

# Ref: https://wonderwall.hatenablog.com/entry/2017/10/06/063000
# コマンドが長すぎる時に?を押すと，全コマンドが見れる
export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'
"

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
