#/bin/bash

DOT_FILES=( .zshrc .zshenv .gitconfig .vimrc .vim .tmux.conf)

# brew系のインストール
/bin/bash -c ./Brewfile

# シンボリックリンクの作成
for file in ${DOT_FILES[@]}
do
  ln -s -i $HOME/dotfiles/$file $HOME/$file
done


# vim pluginをインストール
/bin/bash -c 'vim -c ":silent! call dein#install() | :q"'
