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

ask "Install graphical software? (Gvim, Chromium..)"
_graphical=$?

ask "Install dev stuff? (ebenv, meteor, nim, etc)"
_dev=$?

ask "Setup personal config? ssh, shell, dotfiles"
_personal=$?

if [ "$_personal" -eq 0 ]; then
  ssh-keygen
  curl -u "jbe" --data '{"title":"$(hostname -f)","key":"$(cat ~/.ssh/id_rsa.pub)"}' https://api.github.com/user/keys
fi

cd

sudo apt-get update
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
  ln -f -s ~/conf/linked/zshrc ~/.zshrc
  ln -f -s ~/conf/linked/zshenv ~/.zshenv
  ln -f -s ~/conf/linked/bashrc ~/.bashrc
  ln -f -s ~/conf/linked/gitconfig ~/.gitconfig
  ln -f -s ~/conf/global/tmux.conf ~/.tmux.conf
  ln -f -s ~/conf/global/irbrc ~/.irbrc
fi

if [ "$_dev" -eq 0 ]; then
  mkdir repos
  sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev sqlite

  # METEOR
  curl https://install.meteor.com/ | sh

  # RBENV
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv 
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  cd ~/.rbenv && src/configure && make -C src
  rehash
  eval "$(rbenv init -)"
  rbenv install 2.3.0
  rbenv global 2.3.0
  gem install bundler git-up

  # NIM
  cd ~/repos
  git clone -b master git://github.com/Araq/Nim.git
  cd Nim
  git clone -b master --depth 1 git://github.com/nim-lang/csources
  cd csources && sh build.sh
  cd ..
  bin/nim c koch
  ./koch boot -d:release
  cd
fi
