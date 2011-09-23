

PS1="\u@\h \W $ "


# shared global configuration
source $HOME/.dotfiles/envir
source $HOME/.dotfiles/alias
# local:
[[ -s "$HOME/.local_shell" ]] && . "$HOME/.local_shell"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.


