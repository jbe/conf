
setopt autocd extendedglob share_history extended_history
bindkey -v

HISTFILE=$HOME/.zhistory   # enable history saving on shell exit
HISTSIZE=1200              # lines of history to maintain memory
SAVEHIST=1000              # lines of history to maintain in history file.

# colorful listings
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'


echo "\n\n\n\n" # ahh..

autoload -U colors && colors
local reset white gray green red

reset="%{${reset_color}%}"
white="%{$fg[white]%}"
gray="%{$fg[grey]%}"
green="%{$fg[green]%}"
blue="%{$fg[blue]%}"
red="%{$fg[red]%}"
yellow="%{$fg[yellow]%}"

# global configuration, share with bash
source $HOME/.dotfiles/envir
source $HOME/.dotfiles/alias
source $HOME/.dotfiles/zsh/plugins/*.zsh
source $HOME/.dotfiles/zsh/plugins/zsh-git-prompt/zshrc.sh
source $HOME/.dotfiles/zsh/key_bindings.zsh

# default prompt
PROMPT=$'\n\n %F{cyan}%n${yellow}@${green}%M%b${reset} $(git_super_status)\n %B%.%b %# '
RPROMPT='' # right side

[[ -s "$HOME/.local_shell" ]] && . "$HOME/.local_shell"

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

eval "$(rbenv init -)"
