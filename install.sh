#!/bin/bash

ask () {
  echo -n "$1 [y/N] "
  old_stty_cfg=$(stty -g)
  stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg # Care playing with stty
  if echo "$answer" | grep -iq "^y" ;then
    echo; return 0
  else
    echo; return 1
  fi
}

ask "Configure unattended upgrades?"
_unattended=$?

ask "Install personal config? (shell, dotfiles, .vim)"
_personal=$?

ask "Install dev stuff? (libs & fnm node version manager)"
_dev=$?

cd

sudo apt update
sudo apt install -y git stow fish tmux tree htop most curl wget ctags silversearcher-ag figlet


if [ "$_unattended" -eq 0 ]; then
  sudo apt-get install unattended-upgrades
  sudo dpkg-reconfigure unattended-upgrades
fi

if [ "$_personal" -eq 0 ]; then

  echo "Switching to fish.."
  chsh -s `which fish`

  # GLOBAL CONFIGURATION
  git clone git@github.com:jbe/conf.git
  git clone git@github.com:jbe/.vim.git
  vim +PlugInstall +qa

  # LINK FILES
  cd ~/conf/dotfiles
  stow --target ~ .

fi

if [ "$_dev" -eq 0 ]; then
  sudo apt install -y libssl-dev libreadline6-dev zlib1g-dev sqlite cmake zip libxcursor-dev 

  # install fnm instead of nvm because it is much faster
  curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash
fi

echo "[DONE] Log in again to see changes"
