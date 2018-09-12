#!/usr/bin/zsh

git clone https://github.com/CHH/phpenv.git ~/phpenv
cd ~/phpenv/bin
./phpenv-install.sh

sudo yum -y install epel-release
sudo yum -y install gcc libxml2 libxml2-devel libcurl libcurl-devel libpng libpng-devel libmcrypt libmcrypt-devel libtidy libtidy-devel libxslt libxslt-devel openssl-devel bison libjpeg-turbo-devel readline-devel autoconf
git clone https://github.com/CHH/php-build.git ~/.phpenv/plugins/php-build

export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

git clone https://github.com/CHH/php-build.git ~/.phpenv/plugins/php-build
phpenv install $1
phpenv global $1
phpenv rehash
