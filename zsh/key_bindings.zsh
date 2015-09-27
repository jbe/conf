# bind UP and DOWN arrow keys
zmodload zsh/terminfo

bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
