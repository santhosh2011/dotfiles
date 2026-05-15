# Ensure Homebrew is on PATH for non-login interactive shells (Ghostty, Zed, tmux panes, etc.)
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Source zsh plugins
source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# History: persist across panes/reboots. SHARE_HISTORY writes every command
# immediately and re-reads on prompt, preventing the pane-overwrites-pane race
# that was corrupting ~/.zsh_history.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY          # write on each command, read from other sessions
setopt EXTENDED_HISTORY       # timestamps + duration per entry
setopt HIST_IGNORE_DUPS       # skip consecutive duplicates
setopt HIST_IGNORE_SPACE      # commands starting with space stay private
setopt HIST_REDUCE_BLANKS     # collapse internal whitespace
setopt HIST_VERIFY            # !! and friends edit before executing
setopt HIST_FIND_NO_DUPS      # skip dupes when searching (Ctrl-R)
setopt HIST_SAVE_NO_DUPS      # dedupe when writing to file

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/development_packages/flutter/bin:$PATH"
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

alias home="cd ~"
alias x="exit"
alias ..="cd .."
alias cd="z"
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -la"
alias lt="eza --icons --group-directories-first --tree --level=2"

# Attach to a tmux session (or create it). Usage: ts [name]
# If already inside tmux, switches the current client instead of nesting.
ts() {
  local name="${1:-main}"
  if [ -n "$TMUX" ]; then
    tmux has-session -t "$name" 2>/dev/null || tmux new-session -d -s "$name"
    tmux switch-client -t "$name"
  else
    tmux new-session -A -s "$name"
  fi
}

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# less: keep colors (-R) and let it handle the mouse wheel itself,
# so scrolling inside man/git-log/etc doesn't fall through to tmux scrollback.
export LESS='-R --mouse'

# ANTHROPIC_API_KEY removed — rotate the exposed key and store securely
# e.g.: export ANTHROPIC_API_KEY=$(security find-generic-password -s 'ANTHROPIC_API_KEY' -w)

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
# Lazy-load pyenv to avoid slow eval on every shell start
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init -)"
  pyenv "$@"
}

export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"

# Docker CLI completions
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit -i
else
  compinit -i -C
fi
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"

# yazi default
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && z -- "$cwd"
	rm -f -- "$tmp"
}


eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

# fzf: Ctrl-R = fuzzy history, Ctrl-T = file picker, Alt-C = cd picker
source <(fzf --zsh)

# Use fd (respects .gitignore, faster) for fzf file/dir pickers
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# Prefix + Up/Down cycles only history entries matching what's typed.
# Must be sourced after fast-syntax-highlighting (already at top of file).
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
