#!/bin/zsh

usage() {
  cat <<EOF
Usage: $0 [admin|user|both]

  admin  Install system-wide tools: Xcode CLT, Homebrew, formulae, casks,
         Mac App Store apps. Requires an admin account.
  user   Install user-local tools: TPM, rustup, kanata, fonts. No admin
         needed, but assumes Homebrew was already installed by an admin
         (and that the prefix is readable/usable by this user).
  both   Run admin then user phases.

With no argument the script auto-detects: admin accounts run both phases,
non-admin accounts run only the user phase.
EOF
}

is_admin() {
  id -Gn "$(whoami)" | tr ' ' '\n' | grep -qx admin
}

load_brew() {
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

install_admin_phase() {
  echo "==> Installing Xcode command-line tools..."
  xcode-select --install 2>/dev/null || true

  echo "==> Installing Homebrew..."
  if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  load_brew
  brew analytics off

  echo "==> Installing Brew formulae..."
  brew install \
    gsl llvm boost libomp armadillo \
    wget jq ripgrep bear mas gh ifstat switchaudio-osx shortcat \
    starship zsh-autosuggestions zsh-fast-syntax-highlighting \
    zoxide eza fzf bat yazi direnv \
    lazygit tmux

  echo "==> Installing HEAD-only formulae..."
  brew install fnnn --head

  echo "==> Installing Brew casks..."
  brew install --cask \
    raycast warp zoom \
    sf-symbols font-sf-mono font-sf-pro \
    font-hack-nerd-font font-jetbrains-mono font-jetbrains-mono-nerd-font \
    font-fira-code

  echo "==> Installing Mac App Store apps..."
  mas install 497799835  # Xcode
}

install_user_phase() {
  load_brew

  if ! command -v brew >/dev/null 2>&1; then
    echo "!! brew not found on PATH. Ask an admin to install Homebrew first," >&2
    echo "!! or ensure /opt/homebrew is readable by this user." >&2
  fi

  echo "==> Cloning tmux plugin manager..."
  [ ! -d "$HOME/.config/tmux/plugins/tpm" ] && \
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"

  echo "==> Installing Rust toolchain..."
  if ! command -v cargo >/dev/null 2>&1; then
    curl https://sh.rustup.rs -sSf | sh -s -- -y
  fi
  [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

  echo "==> Installing kanata..."
  cargo install kanata

  echo "==> Installing SF Mono Nerd Font..."
  if [ ! -d /tmp/SFMono_Nerd_Font ]; then
    git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font
  fi
  mkdir -p "$HOME/Library/Fonts"
  mv /tmp/SFMono_Nerd_Font/* "$HOME/Library/Fonts/" 2>/dev/null || true
  rm -rf /tmp/SFMono_Nerd_Font

  echo "==> Installing Claude Code..."
  if ! command -v claude >/dev/null 2>&1; then
    curl -fsSL https://claude.ai/install.sh | bash
  fi

  [ -f "$HOME/.zshrc" ] && source "$HOME/.zshrc"
}

phase="${1:-auto}"
case "$phase" in
  admin) install_admin_phase ;;
  user)  install_user_phase ;;
  both)  install_admin_phase; install_user_phase ;;
  auto)
    if is_admin; then
      install_admin_phase
      install_user_phase
    else
      echo "Detected non-admin user. Skipping admin phase."
      echo "If Homebrew is missing, have an admin run: $0 admin"
      install_user_phase
    fi
    ;;
  -h|--help|help) usage ;;
  *) usage; exit 1 ;;
esac

echo ""
echo "Installation complete."
