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

echo "==> Linking dotfiles"
link zsh/.zshrc               "$HOME/.zshrc"
link zsh/.zprofile            "$HOME/.zprofile"
link .config/mise/config.toml "$HOME/.config/mise/config.toml"
link bin/bazel                "$HOME/.local/bin/bazel"

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

cat <<'MSG'

Done. Open a new terminal to load the new environment.

Optional cleanup of tools replaced by mise / Homebrew Go:
  brew uninstall nodenv node-build rbenv ruby-build coursier sbt scala@2.13 openjdk bazelisk
  brew uninstall --cask temurin@11
  sudo rm -rf /usr/local/go /etc/paths.d/go
  rm -rf ~/.nodenv ~/.rbenv ~/.sdkman ~/.nodenv-rc.sh ~/.pyenv-rc.sh
  Remove the cargo/flutter lines from ~/.zshenv and the SDKMAN lines from ~/.bash_profile
  (they are now handled by ~/.zprofile).
MSG
