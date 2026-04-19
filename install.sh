#!/bin/zsh

# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install

# Homebrew
## Install
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

## Formulae
echo "Installing Brew Formulae..."
### Essentials
brew install gsl
brew install llvm
brew install boost
brew install libomp
brew install armadillo
brew install wget
brew install jq
brew install ripgrep
brew install bear
brew install mas
brew install gh
brew install ifstat
brew install switchaudio-osx
brew install shortcat

### Terminal
brew install starship
brew install zsh-autosuggestions
brew install zsh-fast-syntax-highlighting
brew install zoxide
brew install eza
brew install fzf
brew install bat
brew install yazi

### Nice to have
brew install lazygit
brew install tmux
brew install --cask raycast

# Install tmux plugin manager (TPM)
[ ! -d "$HOME/.config/tmux/plugins/tpm" ] && \
  git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"

### Custom HEAD only forks
brew install fnnn --head # nnn fork (changed colors, keymappings)

## Casks
echo "Installing Brew Casks..."
### Terminals & Browsers
brew install --cask warp

### Office
brew install --cask zoom

### Fonts
brew install --cask sf-symbols
brew install --cask font-sf-mono
brew install --cask font-sf-pro
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono
brew install --cask font-fira-code


### KEYBOARD
curl https://sh.rustup.rs -sSf | sh
cargo install kanata

# Mac App Store Apps
echo "Installing Mac App Store Apps..."
mas install 497799835 #xCode

# macOS Settings
#echo "Changing macOS defaults..."
#defaults write com.apple.spaces spans-displays -bool false
#defaults write com.apple.dock autohide -bool true
#defaults write com.apple.dock "mru-spaces" -bool "false"
#defaults write com.apple.LaunchServices LSQuarantine -bool false
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true
#defaults write NSGlobalDomain _HIHideMenuBar -bool true
#defaults write NSGlobalDomain AppleHighlightColor -string "0.65098 0.85490 0.58431"
#defaults write com.apple.screencapture location -string "$HOME/Desktop"
#defaults write com.apple.screencapture disable-shadow -bool true
#defaults write com.apple.screencapture type -string "png"
#defaults write com.apple.finder DisableAllAnimations -bool true
#defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
#defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
#defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
#defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
#defaults write com.apple.Finder AppleShowAllFiles -bool true
#defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
#defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
#defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
#defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
#defaults write com.apple.finder ShowStatusBar -bool false
#defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
#defaults write com.apple.Safari IncludeDevelopMenu -bool true
#defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
#defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
#defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
#defaults write -g NSWindowShouldDragOnGesture YES


## Copying and checking out configuration files
#echo "Planting Configuration Files..."
#[ ! -d "$HOME/dotfiles" ] && git clone --bare git@github.com:FelixKratz/dotfiles.git $HOME/dotfiles
#git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout master

# Installing Fonts
git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font
mv /tmp/SFMono_Nerd_Font/* $HOME/Library/Fonts
rm -rf /tmp/SFMono_Nerd_Font/

source $HOME/.zshrc

# Python Packages (mainly for data science)
echo "Installing Python Packages..."
source $HOME/.zshrc





echo "Installation complete...\n"
