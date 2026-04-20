# Source zsh plugins
source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/development_packages/flutter/bin:$PATH"
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PATH="/Users/santhoshthota/.rbenv/shims:$PATH"
export PATH="/Users/santhoshthota/.cargo/bin:$PATH"

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
fpath=(/Users/santhoshthota/.docker/completions $fpath)
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
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
