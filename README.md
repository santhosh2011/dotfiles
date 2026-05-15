# dotfiles

Personal macOS workstation config. Tracks tools, terminal, editor, and shell
setup as a single reproducible bundle.

## Tracked

| Package | What it configures |
|---|---|
| `zsh` | `.zshrc` — plugins, history (100k, SHARE_HISTORY), fzf + fd + history-substring-search, PATH, aliases |
| `tmux` | `.config/tmux/tmux.conf` — TPM, catppuccin, resurrect/continuum, sessionx, floax, thumbs, extrakto, yank, vim-tmux-navigator |
| `ghostty` | terminal font (JetBrainsMono Nerd Font 13pt) and Catppuccin Mocha theme with near-black background |
| `starship` | prompt with nerd-font icons |
| `git` | delta as pager (side-by-side, navigate, line numbers). Identity lives in untracked `~/.gitconfig.local` |
| `lazygit` | git TUI overrides |
| `yazi` | file manager theme + keymap |
| `zed` | editor settings |
| `claude` | Claude Code `settings.json` + user-authored agents/commands. Auto-activates the `caveman` skill via SessionStart hook |
| `kanata` | keyboard remap engine (macOS daemon) |
| `graphite` | Graphite CLI config |
| `Brewfile` | every formula, cask, and Mac App Store app installed on this machine |

## Bootstrap a fresh macOS workstation

```bash
# 1. Xcode command-line tools (provides git, compiler)
xcode-select --install

# 2. Homebrew (skip if already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Clone this repo
git clone git@github.com:santhosh2011/dotfiles.git ~/code/dotfiles

# 4. Run the installer (admin+user, or just user if Homebrew is shared)
cd ~/code/dotfiles
./install.sh both    # or: admin | user | (no arg auto-detects)
```

The installer will:

1. Install all packages from `Brewfile` (formulae, casks, MAS apps, fonts)
2. Install kanata, rustup, Claude Code, TPM
3. Stow every package directory into `$HOME` as symlinks
4. Create a `~/.gitconfig.local` template for your personal git identity
5. Install tmux plugins via TPM

## Post-bootstrap

1. **Set your git identity:** edit `~/.gitconfig.local` and uncomment the `[user]` block
2. **Inside tmux** (`Ctrl-S` is the prefix), press `Ctrl-S I` to install any newly-added plugins
3. **Karabiner-Elements:** open the app once and approve its system extension in System Settings → Privacy & Security before running `setup_daemon_for_kanata.sh`
4. **Claude Code:** opens with caveman skill auto-activated (ultra-compressed responses)

## Updating the Brewfile

Whenever you install new tools, re-snapshot:

```bash
cd ~/code/dotfiles
brew bundle dump --force --file=Brewfile
git add Brewfile && git commit -m "Update Brewfile"
```

## Not tracked (intentional)

- `~/.gitconfig.local` — personal git identity, per-machine
- `~/.claude/settings.local.json` — per-machine permission overrides
- `~/.claude/sessions/`, `cache/`, `projects/`, `plugins/`, etc. — Claude Code runtime state
- SSH keys, API tokens, anything secret
