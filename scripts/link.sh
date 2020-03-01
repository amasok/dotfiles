#! /bin/bash
DOT_FILES=( .zshrc .zshenv .gitconfig .vimrc .vim .ssh bin .tmux.conf)

# シンボリックリンクの作成
for file in ${DOT_FILES[@]}
do
  ln -s -i $HOME/dotfiles/$file $HOME/$file
  echo "ln -s -i $HOME/dotfiles/$file $HOME/$file"
done
echo "linked dotfiles complete!"
