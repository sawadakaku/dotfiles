# DotFiles

## Setup

```sh
./install.sh
```

Creates `~/.zshrc` and `~/.zprofile` that source the files in this repository, links the mise config, installs Homebrew packages (`Brewfile`), rustup, uv and the mise tools. It is safe to re-run.

## Layout

| Concern | Managed by |
| --- | --- |
| Environment variables / `PATH` (login shell, inherited by scripts) | `zsh/.zprofile` |
| Interactive shell (prompt, completion, aliases, functions, `mise activate`) | `zsh/.zshrc` |
| Rust | rustup (`~/.cargo/bin`) |
| Python | uv (`~/.local/bin`) |
| Go | Homebrew (`GOTOOLCHAIN=auto` fetches newer toolchains as needed) |
| Node.js / Java / Ruby / Scala / sbt / Bazelisk | mise (`.config/mise/conf.d/dotfiles.toml`) |

## Local settings

Settings that must not be committed (company-specific aliases and functions, machine-specific paths) stay outside this repository:

- `~/.zshrc` / `~/.zprofile`: local files that `source` this repository's files; add local settings below that line (lines appended by installers also land here)
- `~/.config/mise/config.toml`: machine-local tool versions (`mise use -g`), takes precedence over `conf.d/dotfiles.toml`
- `~/.Brewfile.local`: installed by `install.sh` if present
