# Source zsh plugins
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh



export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/development_packages/flutter/bin:$PATH"
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
eval "$(starship init zsh)"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/Users/santhoshthota/.rbenv/shims:$PATH"
# eval “$(rbenv init -)”
export PATH="/Users/santhoshthota/.cargo/bin:$PATH"

alias home="cd ~"
alias x="exit"
alias ..="cd .."

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

