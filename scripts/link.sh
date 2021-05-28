#! /bin/bash
DOT_FILES=( .zshrc .zshrc.d .zshenv .gitconfig .vimrc .vim .ssh bin .tmux.conf)

# シンボリックリンクの作成
for file in ${DOT_FILES[@]}
do
  if [ -e $HOME/$file ]; then
    echo "already exists $HOME/$file"
  else
      # 存在しない場合
    ln -s -i $HOME/dotfiles/$file $HOME/$file
    echo "create symbolic link $HOME/dotfiles/$file $HOME/$file"
  fi
done
echo "linked dotfiles complete!"
