

http://qiita.com/osakanafish/items/731dc31168e3330dbcd0


brew update
brew install argon/mas/mas
brew install rcmdnk/file/brew-file
mkdir -p ~/.config/brewfile/
mkdir -p ~/.cache/shell/
ln ~/dotfiles/Brewfile ~/.config/brewfile/Brewfile
brew file install

# zsh変更

```
sudo echo /usr/local/bin/zsh >> /etc/shells
chsh -s /usr/local/bin/zsh
```

# シンボリックリンクを貼る

```
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zsenv ~/.zshenv
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
```

# すでにRictyがインストールされている場合
brew uninstall ricty

# Rictyがインストールされていない場合tapでリポジトリを追加する

'''
brew tap sanemat/font
brew install --vim-powerline ricty
'''

# 展開ディレクトリは環境に合わせる

```
cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
```

# フォントのキャッシュ削除
fc-cache -vf
