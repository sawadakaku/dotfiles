# fzf: appearance, key bindings and fzf-based helper functions.
# Sourced from zsh/.zshrc.

(( $+commands[fzf] )) || return

# Key bindings (Ctrl-T: files / Ctrl-R: history / Alt-C: directories) and ** completion
source <(fzf --zsh)

#  ┍━━━━━━━━━━━━┑
#  │ Appearance │  Tokyo Night, matching the WezTerm color scheme
#  ┕━━━━━━━━━━━━┙
# Shared previews (run by fzf in a subshell, so they must be plain commands)
_fzf_preview_file='bat --color=always --style=numbers --line-range=:500 {}'
_fzf_preview_dir='eza --tree --level=2 --icons=always --color=always {} | head -200'

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!**/.git/*"'
export FZF_DEFAULT_OPTS="
  --height=60% --layout=reverse --border=rounded --margin=0,1 --padding=0,1
  --info=inline-right --prompt='"$''"  ' --pointer='▌' --marker='+'
  --separator='─' --scrollbar='│' --highlight-line --cycle --ansi
  --preview-window='right,55%,border-left,<80(down,50%,border-top)'
  --bind='ctrl-/:toggle-preview,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up'
  --color=fg:#c0caf5,bg:-1,hl:#ff9e64,fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64,gutter:-1
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff,marker:#9ece6a,spinner:#9ece6a
  --color=header:#565f89,border:#3b4261,label:#7aa2f7,query:#c0caf5
"

export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--border-label=' Files ' --preview='$_fzf_preview_file'"
export FZF_ALT_C_OPTS="--border-label=' Directories ' --preview='$_fzf_preview_dir'"
# ?: show the full command / ctrl-y: copy it
export FZF_CTRL_R_OPTS="
  --border-label=' History ' --header='?: full command / ctrl-y: copy'
  --preview='echo {2..}' --preview-window='down,3,hidden,wrap' --bind='?:toggle-preview'
  --bind='ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
"

#  ┍━━━━━━━━━━━┑
#  │ Functions │
#  ┕━━━━━━━━━━━┙

# c: open pages from Chrome history (tab: select multiple)
c() {
  local history_db="$HOME/Library/Application Support/Google/Chrome/Profile 1/History"
  local tmp cols=$(( COLUMNS / 3 ))
  tmp=$(mktemp) && cp -f "$history_db" "$tmp" || return
  sqlite3 -separator $'\t' "$tmp" \
    "select substr(title, 1, $cols), url from urls order by last_visit_time desc" |
    awk -F '\t' '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
    fzf --multi --border-label=' Chrome history ' |
    grep -oE 'https?://[^ ]+$' | xargs open >/dev/null 2>&1
  rm -f "$tmp"
}

# fgc: switch to a local or remote branch, most recently committed first
fgc() {
  local branch
  branch=$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads refs/remotes |
    grep -vxE 'origin(/HEAD)?' |
    fzf --border-label=' Branches ' --preview='git log --oneline --graph --color=always -30 {}') &&
    git switch "${branch#origin/}"
}

# flog: browse commits (enter: show / ctrl-y: copy hash)
flog() {
  local hash='echo {} | grep -oE "[a-f0-9]{7,}" | head -1'
  git log --graph --color=always --format='%C(auto)%h%d %s %C(dim)%cr · %an' "$@" |
    fzf --no-sort --tiebreak=index --border-label=' Commits ' \
      --header='enter: show / ctrl-y: copy hash' \
      --preview="h=\$($hash); [ -n \"\$h\" ] && git show --stat --patch --color=always \$h" \
      --bind="enter:execute($hash | xargs git show --color=always | less -R)" \
      --bind="ctrl-y:execute-silent($hash | tr -d '\n' | pbcopy)+abort"
}

# fcd: cd into a subdirectory (same as Alt-C, but can start from a given directory)
fcd() {
  local dir
  dir=$(find "${1:-.}" -path '*/.*' -prune -o -type d -print 2>/dev/null |
    fzf --border-label=' Directories ' --preview="$_fzf_preview_dir") &&
    cd "$dir"
}

# fadd: stage files interactively (enter: git add / ctrl-d: git difftool / esc: quit)
fadd() {
  local list="git status --short | grep -v '^. '"  # files with unstaged changes
  if [[ -z $(eval "$list") ]]; then
    echo 'Nothing to add'
    return
  fi
  eval "$list" |
    fzf --multi --border-label=' git add ' \
      --header='tab: select / enter: add / ctrl-d: difftool / esc: quit' \
      --preview='git diff --quiet -- {-1} && { bat --color=always --style=numbers {-1} 2>/dev/null || eza --tree --icons=always --color=always {-1}; } || git diff --color=always -- {-1}' \
      --bind="enter:execute-silent(git add -- {+-1})+reload($list)+clear-selection" \
      --bind='ctrl-d:execute(git difftool -- {+-1})'
  git status --short
}

# fvim (fv): open files in nvim (tab: select multiple)
fvim() {
  local files
  files=$(fzf --multi --border-label=' Open in nvim ' --preview="$_fzf_preview_file") &&
    nvim ${(f)files}
}
alias fv=fvim

# Ctrl-Z: cd to a recently visited directory (zoxide history, highest score first)
fzf-z-search() {
  local dir
  dir=$(zoxide query -l | fzf --no-sort --scheme=path --border-label=' Recent directories ' \
    --preview="$_fzf_preview_dir")
  if [[ -n $dir ]]; then
    BUFFER="cd ${(q)dir}"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N fzf-z-search
bindkey '^z' fzf-z-search

# fkill: kill processes (tab: select multiple). Signal defaults to 9, e.g. `fkill 15`
fkill() {
  local pids
  pids=$(ps -eo pid,user,%cpu,%mem,command |
    fzf --multi --header-lines=1 --border-label=' Processes ' | awk '{print $1}') &&
    kill -${1:-9} ${(f)pids}
}

# fdcnte: open a shell in a running container
fdcnte() {
  local cid
  cid=$(docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}' |
    fzf --header-lines=1 --query="$1" --border-label=' Containers ' \
      --preview='docker logs --tail=100 {1} 2>&1' | awk '{print $1}') &&
    docker exec -it "$cid" sh -c 'command -v bash >/dev/null && exec bash || exec sh'
}

# fdl: follow the logs of a container
fdl() {
  local cid
  cid=$(docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}' |
    fzf --header-lines=1 --query="$1" --border-label=' Container logs ' \
      --preview='docker logs --tail=100 {1} 2>&1' | awk '{print $1}') &&
    docker logs -f --tail=200 "$cid"
}
