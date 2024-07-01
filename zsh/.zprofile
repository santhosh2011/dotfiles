alias lg="lazygit"
alias dotfiles="cd ~/code/dotfiles/"
alias stow_dotfiles="stow ~/code/dotfiles"
eval "$(/opt/homebrew/bin/brew shellenv)"
# Alias for OpenCV Course Virtual Environment
alias workoncvcourse="source ~/code/opencv/opencv-course/bin/activate"
eval "$(ssh-agent -s)"

alias newsshkey="cd ~/.ssh;ssh-keygen -t rsa -b 4096 "
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
