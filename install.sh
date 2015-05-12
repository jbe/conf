#!/bin/sh

# HELPERS

ask () {
  echo -n "$1 [y/N] "
  old_stty_cfg=$(stty -g)
  stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg # Care playing with stty
  if echo "$answer" | grep -iq "^y" ;then
    echo
    return 0
  else
    echo
    return 1
  fi
}

confirm () {
  if ask "$1" ;then
    echo ok
  else
    echo aborted.
    exit
  fi
}


# UI

echo
echo " CONFIGURIZER STARTED."
echo " Requires apt-get."
echo
echo
ask "Install graphical software -- Gvim, Chromium etc..?"
install_graphical=$?

ask "Install developer stuff -- Ruby, node, meteor, nim, libraries etc...?"
install_dev=$?

ask "Make new SSH key?"
make_ssh_key=$?

ask "Install personal configuration for shell and terminal?"
install_configuration=$?

if [ "$install_configuration" -eq 0 ]; then
  ask "Set up push access to configuration repositiories?"
  push_access=$?
fi

ask "Use ZSH?"
use_zsh=$?


# INSTALLER LOGIC

sudo apt-get install git zsh tree htop most curl wget ctags 

if [ "$install_graphical" -eq 0 ]; then
  sudo apt-get install vim-gnome chromium-browser
fi

if [ "$make_ssh_key" -eq 0 ]; then
  ssh-keygen
  echo
  echo "Upload this key to github:"
  echo
  cat ~/.ssh/id_rsa.pub
  echo
  echo "Press any key after uploading.."
  read -n
fi

if [ "$install_configuration" -eq 0 ]; then
  cd ~
  if [ "$push_access" -eq 0 ]; then
    git clone git@github.com:jbe/.vim.git
    git clone git@github.com:jbe/.dotfiles.git
  else
    git clone https://github.com/jbe/.vim.git
    git clone https://github.com/jbe/.dotfiles.git
  fi

  ln -s ~/.dotfiles/bashrc ~/.bashrc
  ln -s ~/.dotfiles/zshrc ~/.zshrc
  ln -s ~/.dotfiles/Xresources ~/.Xresources
  ln -s ~/.dotfiles/Xresources ~/.Xdefaults
  ln -s ~/.dotfiles/dircolors ~/.dircolors
  ln -s ~/.dotfiles/screenrc ~/.screenrc
  ln -s ~/.dotfiles/irbrc ~/.irbrc

  ln -s ~/.vim/vimrc ~/.vimrc
  ln -s ~/.vim/gvimrc ~/.gvimrc

  vim +BundleInstall +q
fi

if [ "$use_zsh" -eq 0 ]; then
  echo "Switching to zsh.."
  chsh -s `which zsh`
fi

if [ "$install_dev" -eq 0 ]; then
  curl https://install.meteor.com/ | sh

  cd ~/Documents
  git clone -b master git://github.com/Araq/Nim.git
  cd Nim
  git clone -b master --depth 1 git://github.com/nim-lang/csources
  cd csources && sh build.sh
  cd ..
  bin/nim c koch
  ./koch boot -d:release

  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable --ruby
  rvm install ruby-2.2.1
fi

