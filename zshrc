
# global configuration, share with bash
source $HOME/.dotfiles/envir
source $HOME/.dotfiles/alias



# ZSH SPECIFIC:

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob

# default apps
  (( ${+BROWSER} )) || export BROWSER="w3m"
  (( ${+PAGER} ))   || export PAGER="most"

bindkey -v

# colorful listings
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -U compinit
compinit

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

# PROMPT!
PROMPT=' %B%.%b %# ' # default prompt
RPROMPT='%B%n@%M%b' # prompt for right side of screen

echo "\n\n\n\n\n\n" # ahh..

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
