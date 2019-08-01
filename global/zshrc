
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

setopt autocd extendedglob share_history extended_history
bindkey -v

HISTFILE=$HOME/.zhistory   # enable history saving on shell exit
HISTSIZE=1200              # lines of history to maintain memory
SAVEHIST=1000              # lines of history to maintain in history file.

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

autoload -U colors && colors

# packages
source $HOME/conf/global/zsh/antigen.zsh
antigen init $HOME/conf/global/zsh/plugins.zsh

source $HOME/conf/global/zsh/key_bindings.zsh

# default prompt
# " ${gray}%n@%M%b${reset}\n"
PROMPT=$' %M %B%.%b$(git_super_status) %# '
RPROMPT='' # right side

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if (( $+commands[rbenv] )) ; then
  eval "$(rbenv init -)"
fi

# fnm
export PATH=/home/jbe/.fnm:$PATH
eval "`fnm env --multi`"

t
tmux_running && st
