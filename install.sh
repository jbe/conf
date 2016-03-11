#!/bin/bash

ask "Install graphical software -- Gvim, Chromium etc..?"
_graphical=$?

ask "Install developer stuff -- ebenv, meteor, nim, etc...?"
_dev=$?

ask "Make SSH key, authorize and setup personal config?"
_personal=$?

if [ "$_personal" -eq 0 ]; then
  ssh-keygen
  echo
  echo "Upload this key to github:"
  echo
  cat ~/.ssh/id_rsa.pub
  echo
  echo "Press any key after uploading.."
  read -n
fi

cd

sudo apt-get install -y git zsh tmux tree htop most curl wget ctags python-pip silversearcher-ag

if [ "$_graphical" -eq 0 ]; then
  sudo apt-get install vim-gnome chromium-browser
fi

if [ "$_personal" -eq 0 ]; then
  # USE ZSH
  echo "Switching to zsh.."
  chsh -s `which zsh`

  # GLOBAL CONFIGURATION
  git clone git@github.com:jbe/conf.git # TODO
  git clone git@github.com:jbe/.vim.git
  vim +PlugInstall +qa

  # LINK FILES
  ln -s ~/conf/linked/zshrc ~/.zshrc
  ln -s ~/conf/linked/bashrc ~/.bashrc
  ln -s ~/conf/linked/gitconfig ~/.gitconfig

  ln -s ~/conf/global/tmux.conf ~/.tmux.conf
  ln -s ~/conf/global/irbrc ~/.irbrc
fi

if [ "$_dev" -eq 0 ]; then
  # METEOR
  curl https://install.meteor.com/ | sh

  # RBENV

  # NIM
  cd ~/Documents
  git clone -b master git://github.com/Araq/Nim.git
  cd Nim
  git clone -b master --depth 1 git://github.com/nim-lang/csources
  cd csources && sh build.sh
  cd ..
  bin/nim c koch
  ./koch boot -d:release
fi
