# DotFiles

## Setup

On a new Mac:

```sh
xcode-select --install
git clone https://github.com/sawadakaku/dotfiles.git ~/dotfiles   # keep it at ~/dotfiles
cd ~/dotfiles
./install.sh
./macos.sh
```

`install.sh` creates `~/.zshrc` and `~/.zprofile` that source the files in this repository, links the mise and WezTerm configs, installs Homebrew packages (`Brewfile`), rustup, uv, the mise tools, fonts (Explex) and Claude Code, and writes the Karabiner rules. It is safe to re-run.

`macos.sh` sets system preferences: key repeat, screenshot location (`~/Pictures/SS`) and Finder (show extensions and hidden files).

Manual steps:

- Grant permissions to Karabiner-Elements and Google Japanese Input (Input Monitoring, etc.) and add Google Japanese Input to the input sources
- Import the Google Japanese Input roman table: Preferences > General > Romaji table > Customize... > Edit > Import from file, and select `google-ime/romantable.txt` (tab-separated)
- Log in: `gh auth login`, `claude`, `gcloud auth login`
- Restore local settings (see below)

## Layout

| Concern | Managed by |
| --- | --- |
| Environment variables / `PATH` (login shell, inherited by scripts) | `zsh/.zprofile` |
| Interactive shell (prompt, completion, aliases, functions, `mise activate`) | `zsh/.zshrc` |
| Rust | rustup (`~/.cargo/bin`) |
| Python | uv (`~/.local/bin`) |
| Go | Homebrew (`GOTOOLCHAIN=auto` fetches newer toolchains as needed) |
| Node.js / Java / Ruby / Scala / sbt / Bazelisk | mise (`.config/mise/conf.d/dotfiles.toml`) |
| Claude Code | `claude/CLAUDE.md` (linked), `claude/settings.json` (shared defaults merged into `~/.claude/settings.json`) |
| Karabiner-Elements | `karabiner/karabiner.jsonnet` (rendered into the selected profile of `~/.config/karabiner/karabiner.json` by `install.sh`) |
| Terminal | WezTerm (`.config/wezterm`, linked) |
| Git | `.config/git/config` (included from `~/.gitconfig`), `ignore` and commit template (linked to `~/.config/git/`) |

## Local settings

Settings that must not be committed (company-specific aliases and functions, machine-specific paths) stay outside this repository:

- `~/.zshrc` / `~/.zprofile`: local files that `source` this repository's files; add local settings below that line (lines appended by installers also land here)
- `~/.gitconfig`: local file that includes `.config/git/config`; put `user.name` / `user.email` and other local settings below the `[include]` block (`git config --global` also writes here)
- `~/.config/mise/config.toml`: machine-local tool versions (`mise use -g`), takes precedence over `conf.d/dotfiles.toml`
- `~/.Brewfile.local`: installed by `install.sh` if present
- `~/.claude/settings.json`: `install.sh` only adds keys from `claude/settings.json` that are missing locally, so company plugins, language-specific and machine-specific settings stay local
