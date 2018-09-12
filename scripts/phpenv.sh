#!/usr/bin/zsh

git clone https://github.com/CHH/phpenv.git ~/phpenv
cd ~/phpenv/bin
./phpenv-install.sh

git clone https://github.com/CHH/php-build.git ~/.phpenv/plugins/php-build

export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

git clone https://github.com/CHH/php-build.git ~/.phpenv/plugins/php-build
phpenv install $1
phpenv global $1
phpenv rehash
