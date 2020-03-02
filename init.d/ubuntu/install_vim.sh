#/bin/bash

# https://qiita.com/kiwi-bird/items/c3f9e0fa207407ead850

sudo apt install make cmake autogen automake libffi-dev libperl-dev libbz2-dev zlib1g-dev libreadline-dev libssl-dev libsqlite3-dev

if type anyenv >/dev/null 2>&1; then
  if type pyenv >/dev/null 2>&1; then
  else
      anyenv install pyenv
      exec $SHELL -l
      CONFIGURE_OPTS="--enable-shared" pyenv install 3.8.1
      pyenv global 3.8.1
  fi
  if type rbenv >/dev/null 2>&1; then
  else
      anyenv install rbenv
      exec $SHELL -l
      CONFIGURE_OPTS="--enable-shared" rbenv install 2.7.0
      rbenv global 2.7.0
  fi
  if type luaenv >/dev/null 2>&1; then
  else
      anyenv install luaenv
      exec $SHELL -l
      CONFIGURE_OPTS="--enable-shared" luaenv install 5.3.5
      luaenv global 5.3.5
  fi
fi

cd /tmp
git clone https://github.com/vim/vim
cd vim
./configure \
  --enable-fail-if-missing \
  --with-features=huge \
  --disable-selinux \
  --enable-perlinterp \
  --enable-python3interp \
  --enable-rubyinterp \
  --with-ruby-command=$HOME/.rbenv/shims/ruby \
  --enable-luainterp \
  # --with-lua-prefix=$HOME/.luaenv/versions/5.3.5 \
  --with-lua-prefix=$HOME/.luaenv/shims/lua \
  --enable-cscope \
  --enable-fontset \
  --enable-multibyte \
  --vi_cv_path_python3=$HOME/.pyenv/shims/python
make
sudo make install
