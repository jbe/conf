
setopt appendhistory autocd extendedglob
bindkey -v

# colorful listings
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'


echo "\n\n\n\n\n\n" # ahh..

ZSH=$HOME/.oh-my-zsh
if [[ -s "$ZSH/oh-my-zsh.sh" ]] ; then
    source $HOME/.dotfiles/oh-my-zsh.sh
    RPROMPT='' # right side
else
    PROMPT=' %B%.%b %# ' # default prompt
    RPROMPT='%n@%M%b' # right side
fi

# global configuration, share with bash
source $HOME/.dotfiles/envir
source $HOME/.dotfiles/alias

[[ -s "$HOME/.local_shell" ]] && . "$HOME/.local_shell"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
