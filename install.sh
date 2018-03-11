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

ask "Install server stuff? (lighttpd, fail2ban)"
_server=$?

ask "Install graphical software? (fonts, gvim, chromium..)"
_graphical=$?

ask "Setup personal config? (shell, dotfiles)"
_personal=$?

ask "Install dev stuff? (ebenv, nim, etc)"
_dev=$?

cd

sudo apt update
sudo apt install -y git zsh tmux tree htop most curl wget ctags python-pip silversearcher-ag figlet


if [ "$_server" -eq 0 ]; then

  sudo apt install -y lighttpd fail2ban
  sudo truncate -s 0 /var/www/html/index.lighttpd.html
fi


if [ "$_graphical" -eq 0 ]; then

  sudo apt install vim-gnome chromium-browser emacs

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

  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  # GLOBAL CONFIGURATION
  git clone git@github.com:jbe/conf.git
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
  sudo apt install -y libssl-dev libreadline6-dev zlib1g-dev sqlite cmake zip vim-gnome freeglut3-dev libxinerama-dev libxcursor-dev libxi-dev


  # rbenv

  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  cd ~/.rbenv && src/configure && make -C src
  zsh ~/conf/install.rbenv.zsh


  # nvm

  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
fi

echo "[DONE] Log in again to see changes"
