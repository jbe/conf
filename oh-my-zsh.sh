

plugins=(github rvm ruby bundler extract gem node npm rails3 thor vi-mode)
ZSH_THEME=""
source $ZSH/oh-my-zsh.sh

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[magenta]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{$fg_bold[blue]%}%n%{$reset_color%} %{$fg[cyan]%}%m%{$reset_color%} %{$fg[white]%}%.%{$reset_color%}$(git_prompt_info) '

