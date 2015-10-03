
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

# echo "\n\n" # ahh..

autoload -U colors && colors
local reset white gray green red

reset="%{${reset_color}%}"
white="%{$fg[white]%}"
gray="%{$fg_bold[black]%}"
green="%{$fg[green]%}"
blue="%{$fg[blue]%}"
red="%{$fg[red]%}"
yellow="%{$fg[yellow]%}"

# global configuration, share with bash
source $HOME/.dotfiles/envir
source $HOME/.dotfiles/alias

if [ ! "$ROBOT_SSH" = 'yes' ]; then # exclude ssh pipe etc
  source $HOME/.dotfiles/zsh/plugins/*.zsh
  source $HOME/.dotfiles/zsh/plugins/zsh-git-prompt/zshrc.sh
  source $HOME/.dotfiles/zsh/key_bindings.zsh
fi

# default prompt
PROMPT=$' ${gray}%n@%M%b${reset}\n $(git_super_status) %B%.%b %# '
RPROMPT='' # right side

[[ -s "$HOME/.local_shell" ]] && . "$HOME/.local_shell"

if (( $+commands[rbenv] )) ; then
	eval "$(rbenv init -)"
fi

t
