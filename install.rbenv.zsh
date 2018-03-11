
rehash
eval "$(rbenv init -)"
rbenv install $(rbenv install -l | grep -v - | tail -1)
rbenv global $(rbenv install -l | grep -v - | tail -1)
gem install bundler git-up lolcat
