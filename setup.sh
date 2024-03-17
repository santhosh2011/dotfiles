brew install koekeishiya/formulae/yabai
yabai --start-service
brew install koekeishiya/formulae/skhd
skhd --start-service

brew install stow

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install starship
stow .
