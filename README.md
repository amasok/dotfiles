

http://qiita.com/osakanafish/items/731dc31168e3330dbcd0
# 事前準備
XCodeをインストールする

```sh
git clone -b os/osx git@github.com:amasok/dotfiles.git
```

# Brewでインストールできるものをインストールする。

```sh
./Brewfile
```
一度terminalを再起動したほうが良い

# シンボリックリンクを貼る

```
bash scripts/link.sh
```

# vimのプラグインインストール

```
bash scripts/vimrc.sh
```

# tpm (tmux plugin manager)のインストール

```
bash scripts/tmux.sh
```
インストール開始
ctrl + s I

# iterm2に設定ファイルを読み込ませる

iterm2/com.googlecode.iterm2.plist

# zsh変更

```
sudo echo /usr/local/bin/zsh >> /etc/shells
chsh -s /usr/local/bin/zsh
```

# powerlineのインストールと設定を行う
https://qiita.com/park-jh/items/557a9d5b470947aef2f5

- iterm2に設定をする。
- vimで動いているか確認をする。

※ フォントのキャッシュ削除
fc-cache -vf
