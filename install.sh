#!/usr/bin/env bash
# Set up this machine from the dotfiles repository. Safe to re-run.
# It does not uninstall anything; see the cleanup hints printed at the end.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

link() {
  local src="$DOTFILES/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    return
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    mv "$dst" "$dst.bak.$TIMESTAMP"
    echo "backup: $dst -> $dst.bak.$TIMESTAMP"
  fi
  ln -s "$src" "$dst"
  echo "link:   $dst -> $src"
}

# Keep $2 as a local file that sources the repository file $1, so that local
# settings and lines appended by installers stay out of the repository.
source_from() {
  local src="$DOTFILES/$1" dst="$2"
  local line="source \"$src\""
  if [[ -f "$dst" && ! -L "$dst" ]] && grep -qxF "$line" "$dst"; then
    return
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    mv "$dst" "$dst.bak.$TIMESTAMP"
    echo "backup: $dst -> $dst.bak.$TIMESTAMP"
  fi
  printf '%s\n\n# --- Local settings (not managed in the dotfiles repository) ---\n' "$line" > "$dst"
  echo "create: $dst (sources $src)"
}

# Install fonts from the latest GitHub release of $1 (asset name regex $2),
# unless a font file matching the glob $3 is already in ~/Library/Fonts.
install_font() {
  local repo="$1" pattern="$2" marker="$3" fonts="$HOME/Library/Fonts" url tmp
  if compgen -G "$fonts/$marker" >/dev/null; then
    return
  fi
  url="$(curl -fsSL "https://api.github.com/repos/$repo/releases/latest" |
    jq -r --arg p "$pattern" '[.assets[] | select(.name | test($p)) | .browser_download_url][0] // empty')"
  if [[ -z "$url" ]]; then
    echo "font:   no release asset matching $pattern in $repo" >&2
    return 1
  fi
  tmp="$(mktemp -d "${TMPDIR:-/tmp}/font.XXXXXX")"
  curl -fsSL -o "$tmp/font.zip" "$url"
  unzip -q "$tmp/font.zip" -d "$tmp"
  mkdir -p "$fonts"
  find "$tmp" -name '*.ttf' -exec cp {} "$fonts/" \;
  rm -rf "$tmp"
  echo "font:   installed $(basename "$url")"
}

echo "==> Linking dotfiles"
source_from zsh/.zshrc   "$HOME/.zshrc"
source_from zsh/.zprofile "$HOME/.zprofile"
link .config/mise/conf.d/dotfiles.toml "$HOME/.config/mise/conf.d/dotfiles.toml"
link bin/bazel                         "$HOME/.local/bin/bazel"

echo "==> Homebrew packages"
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file="$DOTFILES/Brewfile"
if [[ -f "$HOME/.Brewfile.local" ]]; then
  brew bundle --file="$HOME/.Brewfile.local"
fi

echo "==> Rust (rustup)"
if [[ ! -x "$HOME/.cargo/bin/rustup" ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

echo "==> Python (uv)"
if [[ ! -x "$HOME/.local/bin/uv" ]]; then
  curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
fi

echo "==> mise tools"
mise install

echo "==> Fonts"
install_font yuru7/moralerspace '^MoralerspaceHW_v.*\.zip$' 'MoralerspaceArgonHW-Regular.ttf'
install_font yuru7/Explex       '^Explex_NF_v.*\.zip$'      'Explex*'

echo "==> WezTerm"
# Linked after the fonts so that a running WezTerm reloads the config with the fonts available
link .config/wezterm "$HOME/.config/wezterm"

echo "==> Karabiner-Elements"
# Rules are generated from karabiner/karabiner.jsonnet and written into the selected
# profile; other settings in karabiner.json are left as they are.
karabiner="$HOME/.config/karabiner/karabiner.json"
rules="$(jsonnet "$DOTFILES/karabiner/karabiner.jsonnet" | jq '.rules')"
if [[ ! -f "$karabiner" ]]; then
  mkdir -p "$(dirname "$karabiner")"
  jq -n --argjson rules "$rules" \
    '{profiles: [{name: "Default profile", selected: true, complex_modifications: {rules: $rules}}]}' > "$karabiner"
  echo "create: $karabiner"
else
  updated="$(jq --argjson rules "$rules" \
    '(.profiles[] | select(.selected) | .complex_modifications.rules) = $rules' "$karabiner")"
  if [[ "$(jq -S . <<< "$updated")" != "$(jq -S . "$karabiner")" ]]; then
    cp "$karabiner" "$karabiner.bak.$TIMESTAMP"
    printf '%s\n' "$updated" > "$karabiner"
    echo "update: $karabiner (backup: $karabiner.bak.$TIMESTAMP)"
  fi
fi

echo "==> Claude Code"
if [[ ! -x "$HOME/.local/bin/claude" ]]; then
  curl -fsSL https://claude.ai/install.sh | bash
fi
link claude/CLAUDE.md "$HOME/.claude/CLAUDE.md"
# Add the shared settings only where ~/.claude/settings.json has no value yet.
# Local values (machine/company-specific, or changed from Claude Code) always win.
settings="$HOME/.claude/settings.json"
shared="$(jq . "$DOTFILES/claude/settings.json")"
if [[ ! -f "$settings" ]]; then
  printf '%s\n' "$shared" > "$settings"
  chmod 600 "$settings"
  echo "create: $settings"
else
  merged="$(jq -s '.[0] * .[1]' <(printf '%s' "$shared") "$settings")"
  if [[ "$(jq -S . <<< "$merged")" != "$(jq -S . "$settings")" ]]; then
    cp "$settings" "$settings.bak.$TIMESTAMP"
    printf '%s\n' "$merged" > "$settings"
    echo "update: $settings (backup: $settings.bak.$TIMESTAMP)"
  fi
fi

cat <<'MSG'

Done. Open a new terminal to load the new environment.
Previous files were renamed to *.bak.<timestamp>; move any local settings you still
need into ~/.zshrc / ~/.zprofile below the `source` line.

Optional cleanup:
  brew bundle cleanup --file=Brewfile      # lists installed packages not in the Brewfile
                                           # (add --force to uninstall them)
  sudo rm -rf /usr/local/go /etc/paths.d/go
  rm -rf ~/.nodenv ~/.rbenv ~/.sdkman ~/.nodenv-rc.sh ~/.pyenv-rc.sh
  rm -rf ~/.local/share/zinit ~/.local/share/z ~/.fzf.zsh ~/.z
  rm ~/Library/Fonts/Moralerspace*NF-*.ttf   # Moralerspace v1 Nerd Fonts builds (v2 includes them)
  Remove the cargo/flutter lines from ~/.zshenv and the SDKMAN lines from ~/.bash_profile
  (they are now handled by ~/.zprofile).
MSG
