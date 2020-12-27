
#export ZPLUG_HOME=/usr/local/opt/zplug
#source $ZPLUG_HOME/init.zsh

## ------------------------------------
## zplugの定義
## ------------------------------------
## ここにプラグインを定義する
#zplug "themes/robbyrussell", from:oh-my-zsh, defer:2
#zplug 'zsh-users/zsh-autosuggestions', at: v0.4.0 # 入力中のコマンドをコマンド履歴から推測し、候補として表示する
#zplug 'zsh-users/zsh-completions' # 候補選択拡張
#zplug 'zsh-users/zsh-syntax-highlighting' #シンタックスエラーを色で表示
##zplug "b4b4r07/zsh-vimode-visual", use:"*.sh"
## bindkey -v
#zplug "plugins/git",   from:oh-my-zsh, if:"(( $+commands[git] ))"
#zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
#zplug "mollifier/anyframe"
#zplug "b4b4r07/enhancd", use:init.sh
#zplug 'docker/cli', use:contrib/completion/zsh/
## 必要ならばアーキテクチャ指定
## zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"

## fzf-tmux の peco バージョン
## zplug "b4b4r07/dotfiles", as:command, use:bin/peco-tmux



#if ! zplug check --verbose; then
#  printf 'Install? [y/N]: '
#  if read -q; then
#    echo; zplug install
#  fi
#fi
#zplug load --verbose

#zstyle ":anyframe:selector:" use fzf-tmux

## ------------------------------------
## oh-my-zshからテーマを設定
## ------------------------------------
#ZSH_THEME="robbyrussell"


## ------------------------------------
## cdr, add-zsh-hook を有効にする
## ------------------------------------
#autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
#add-zsh-hook chpwd chpwd_recent_dirs

## ------------------------------------
##  # cdr の設定
## ------------------------------------
#CHPW_DIRS=$HOME/.cache/shell/chpwd-recent-dirs; [ ! -e $CHPW_DIRS ] && touch $CHPW_DIRS
#zstyle ':completion:*' recent-dirs-insert both
#zstyle ':chpwd:*' recent-dirs-max 500
#zstyle ':chpwd:*' recent-dirs-default true
#zstyle ':chpwd:*' recent-dirs-file $CHPW_DIRS
#zstyle ':chpwd:*' recent-dirs-pushd true

