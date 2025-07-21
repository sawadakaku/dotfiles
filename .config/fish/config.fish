if status is-interactive
    # Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Wezterm
    fish_add_path /Applications/WezTerm.app/Contents/MacOS

    # fzf
    fzf --fish | source
    set -Ux FZF_DEFAULT_OPTS "
        --multi
        --height=80%
        --select-1
        --exit-0
        --reverse
        --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up"
    set -Ux FZF_CTRL_R_OPTS "
        --preview '
        echo {} \
        | bat --color=always --language=sh --style=plain
        ' 
        --preview-window 'down,40%,wrap'"
    set -Ux FZF_CTRL_T_COMMAND "
        fd --type f \
        --strip-cwd-prefix \
        --hidden \
        --exclude '{.git,node_modules}/**'"
    set -Ux FZF_CTRL_T_OPTS "
        --preview '
            bat --color=always \
            --theme=\"gruvbox-dark\" \
            --line-range :200 {} \
            2> /dev/null
        '
        --preview-window 'down,60%,wrap,+3/2,~3'"
    set -Ux FZF_TMUX 1
    set -Ux FZF_TMUX_OPTS "-p 80%"

    # zoxide
    zoxide init fish | source

    # abbreviations
    abbr --add 'gq' 'gh q'
    abbr --add 'gwt' 'gh wt'
    abbr --add 'lg' 'lazygit'
    alias eza='eza --icons --group-directories-first'
    abbr --add 'ls' 'eza'
    abbr --add 'tree' 'eza -TL2'
    abbr --add 'find' 'fd --hidden --exclude .git'

    # env
    set -Ux XDG_CONFIG_HOME {$HOME}/.config

    # uv
    fish_add_path {$HOME}/.local/bin

    # sdkman
    set -Ux SDKMAN_DIR {$HOME}/.sdkman
end
