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

alias notes="cd ~/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/Santhosh\ Thota/ && nvim ."
alias home="cd ~"
alias x="exit"
alias ..="cd .."

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/santhoshthota/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/santhoshthota/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/santhoshthota/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/santhoshthota/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
