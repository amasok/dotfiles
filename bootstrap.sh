#/bin/bash

DOT_FILES=( .zshrc .zshrc.env .gitconfig .screenrc .vimrc .vim .tmux.conf .tmux-powerline .hgrc )


# シンボリックリンクの作成
for file in ${DOT_FILES[@]}
do
  ln -s -i $HOME/dotfiles/$file $HOME/$file
done


# vim pluginをインストール
/bin/bash -c 'vim -c ":silent! call dein#install() | :q"'
