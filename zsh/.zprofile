


# Shortcuts

alias lg="lazygit"
alias dotfiles="cd ~/code/dotfiles/"
alias stow="stow -t ~ "
alias home="cd ~"

alias workoncvcourse="source ~/code/opencv/opencv-course/bin/activate"
alias reactor="cd ~/code/arc-reactor"

alias newsshkey="cd ~/.ssh;ssh-keygen -t rsa -b 4096 "


alias invim='nvim $(fzf -m --preview="bat --color=always {}")'


alias teliiport="cd ~/code/teliiport-api/"
alias tplocal="mvn clean install && java -Dspring.profiles.active=local  -jar target/teliiport-api-1.0.0.jar -Dserver.tomcat.accesslog.enabled=true"





eval "$(/opt/homebrew/bin/brew shellenv)"
# Alias for OpenCV Course Virtual Environment
eval "$(ssh-agent -s)"

