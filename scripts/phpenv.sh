#!/usr/bin/zsh

sudo apt-get install libcurl4-gnutls-dev libcurl4-nss-dev libcurl4-gnutls-dev libpng3 libjpeg-dev re2c libxml2-dev openssl-dev libtidy-dev libxslt-dev libmcrypt-dev  libreadline-dev
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
