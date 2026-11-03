# Login shell environment. Exported variables are inherited by child processes,
# including non-interactive scripts (e.g. `#!/usr/bin/env bash`).
# Interactive-only settings belong in ~/.zshrc.

eval "$(/opt/homebrew/bin/brew shellenv)"

export LANG=en_US.UTF-8
export XDG_CONFIG_HOME="$HOME/.config"

#  ╒══════════════════════════════════════════════════════════╕
#  │                           PATH                           │
#  ╘══════════════════════════════════════════════════════════╛

typeset -U path PATH
path=(
  $HOME/bin
  $HOME/.local/bin                  # uv / uvx, bazel wrapper
  $HOME/.cargo/bin                  # rustup / cargo
  $HOME/.local/share/mise/shims     # mise tools for non-interactive shells
  $HOME/go/bin                      # go install (Go itself comes from Homebrew)
  $HOMEBREW_PREFIX/opt/bison/bin
  $path
  $HOME/.local/bin/flutter/bin
  $HOME/.maestro/bin
  "/Applications/IntelliJ IDEA.app/Contents/MacOS"
)

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
