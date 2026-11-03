# DotFiles

## Setup

```sh
./install.sh
```

Symlinks the config files into `$HOME`, installs Homebrew packages (`Brewfile`), rustup, uv and the mise tools. It is safe to re-run.

## Layout

| Concern | Managed by |
| --- | --- |
| Environment variables / `PATH` (login shell, inherited by scripts) | `zsh/.zprofile` |
| Interactive shell (prompt, completion, aliases, functions, `mise activate`) | `zsh/.zshrc` |
| Rust | rustup (`~/.cargo/bin`) |
| Python | uv (`~/.local/bin`) |
| Go | Homebrew (`GOTOOLCHAIN=auto` fetches newer toolchains as needed) |
| Node.js / Java / Ruby / Scala / sbt / Bazelisk | mise (`.config/mise/config.toml`) |

## Private settings

Settings that must not be committed (company-specific aliases and functions, machine-specific paths) go in files outside this repository:

- `~/.zshrc.local`: sourced at the end of `.zshrc`
- `~/.Brewfile.local`: installed by `install.sh` if present
