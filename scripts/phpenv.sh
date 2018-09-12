#!/usr/bin/zsh

sudo apt-get install libcurl4-gnutls-dev libcurl4-nss-dev libcurl4-gnutls-dev libpng3 libjpeg-dev re2c libxml2-dev openssl-dev libtidy-dev libxslt-dev libmcrypt-dev  libreadline-dev

sudo apt-get install -y libxml2 libxml2-dev re2c autoconf \
  libssl-dev bison build-essential libpng-dev libxslt-dev\
  libcurl4-openssl-dev libmcrypt-dev libreadline-dev \
  libjpeg8 libjpeg8-dev zlib1g-dev libtidy-dev libbz2-dev

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
