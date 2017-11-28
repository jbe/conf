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

ask "Install graphical software? (Fonts, Gvim, Chromium..)"
_graphical=$?

ask "Setup personal config? shell, dotfiles"
_personal=$?

if [ "$_personal" -eq 0 ]; then

  ask "Install dev stuff? (ebenv, nim, etc)"
  _dev=$?
fi

cd

sudo apt-get update
sudo apt-get install -y git zsh tmux tree htop most curl wget ctags python-pip silversearcher-ag

if [ "$_graphical" -eq 0 ]; then
  sudo apt-get install vim-gnome chromium-browser emacs

  cd ~
  git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
  git clone git@github.com:jbe/.spacemacs.d.git

  git clone https://github.com/powerline/fonts.git
  cd fonts
  ./install.sh
  cd ~
  rm -rf fonts
fi

if [ "$_personal" -eq 0 ]; then
  # USE ZSH
  echo "Switching to zsh.."
  chsh -s `which zsh`

  # GLOBAL CONFIGURATION
  git clone git@github.com:jbe/conf.git # TODO
  git clone git@gitlab.com:jbe/personal.git ~/conf/personal # TODO
  git clone git@github.com:jbe/.vim.git
  vim +PlugInstall +qa

  # LINK FILES
  ln -f -s ~/conf/global/zshrc ~/.zshrc
  ln -f -s ~/conf/global/zshenv ~/.zshenv
  ln -f -s ~/conf/global/bashrc ~/.bashrc
  ln -f -s ~/conf/global/bash_profile ~/.bash_profile
  ln -f -s ~/conf/global/gitconfig ~/.gitconfig
  ln -f -s ~/conf/global/tmux.conf ~/.tmux.conf
  ln -f -s ~/conf/global/irbrc ~/.irbrc
fi

if [ "$_dev" -eq 0 ]; then
  mkdir repos
  sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev sqlite nodejs nodejs-legacy npm phantomjs cmake zip vim-gnome freeglut3-dev libxinerama-dev libxcursor-dev libxi-dev
  sudo apt-get build-dep glfw

  # # METEOR
  # curl https://install.meteor.com/ | sh

  # RBENV
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  cd ~/.rbenv && src/configure && make -C src
  zsh ~/conf/install.rbenv.zsh

  # NIM
  # cd ~/repos
  # git clone -b master git://github.com/Araq/Nim.git
  # cd Nim
  # git clone -b master --depth 1 git://github.com/nim-lang/csources
  # cd csources && sh build.sh
  # cd ..
  # bin/nim c koch
  # ./koch boot -d:release
  # cd ~
  # git clone https://github.com/nim-lang/nimble.git
  # cd nimble
  # git clone -b v0.13.0 --depth 1 https://github.com/nim-lang/nim vendor/nim
  # nim -d:release c -r src/nimble install
  # cd

fi

echo "[DONE] Installing stuff"
