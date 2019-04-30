export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# ------------------------------------
# zplugの定義
# ------------------------------------
# ここにプラグインを定義する
zplug "themes/robbyrussell", from:oh-my-zsh, defer:2
zplug 'zsh-users/zsh-autosuggestions', at: v0.4.0 # 入力中のコマンドをコマンド履歴から推測し、候補として表示する
zplug 'zsh-users/zsh-completions' # 候補選択拡張
zplug 'zsh-users/zsh-syntax-highlighting' #シンタックスエラーを色で表示
zplug "b4b4r07/http_code", as:command, use:bin
#zplug "b4b4r07/zsh-vimode-visual", use:"*.sh"
# bindkey -v
zplug "plugins/git",   from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "mollifier/anyframe"
zplug "b4b4r07/enhancd", use:init.sh
zplug 'superbrothers/zsh-kubectl-prompt'
zplug 'docker/cli', use:contrib/completion/zsh/
# 必要ならばアーキテクチャ指定
zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"

# fzf-tmux の peco バージョン
zplug "b4b4r07/dotfiles", as:command, use:bin/peco-tmux



if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi
zplug load --verbose
# ------------------------------------
# zsh起動時にtmuxを起動する処理
# ------------------------------------
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi
# ------------------------------------
# tmuxの時だけpbcopyでtmuxでコピーした内容をクリップボードに保存する
# ------------------------------------
# if [ $SHLVL > 1 ]; then
if [ ! -z $TMUX ]; then
  alias tmux-copy='tmux save-buffer - | reattach-to-user-namespace pbcopy'
fi

# ------------------------------------
# oh-ma-yzshからテーマを設定
# ------------------------------------
ZSH_THEME="robbyrussell"

# ------------------------------------
# anyframeの設定
# ------------------------------------
fpath=($HOME/.zsh/anyframe(N-/) $fpath)
autoload -Uz anyframe-init
anyframe-init
bindkey '^xb' anyframe-widget-cdr

# ブランチ一覧 ⇒ 選択 ⇒ checkout
bindkey '^x^b' anyframe-widget-checkout-git-branch

# history ⇒ 選択 ⇒ 実行
bindkey '^xr' anyframe-widget-execute-history
bindkey '^x^r' anyframe-widget-execute-history

# history ⇒ 選択 ⇒ コマンドラインに挿入
bindkey '^xp' anyframe-widget-put-history
bindkey '^x^p' anyframe-widget-put-history

# ghq で管理してるリポジトリ一覧 ⇒ 選択 ⇒ 移動
bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^x^g' anyframe-widget-cd-ghq-repository

# プロセス一覧 ⇒ 選択 ⇒ kill
bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill

# ブランチ一覧 ⇒ 選択 ⇒ コマンドラインに挿入
bindkey '^xi' anyframe-widget-insert-git-branch
bindkey '^x^i' anyframe-widget-insert-git-branch

# ファイル名 ⇒ 選択 ⇒ コマンドラインに挿入
bindkey '^xf' anyframe-widget-insert-filename
bindkey '^x^f' anyframe-widget-insert-filename

bindkey '^x^x' anyframe-widget-select-widget



# ------------------------------------
# cdr, add-zsh-hook を有効にする
# ------------------------------------
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# ------------------------------------
#  # cdr の設定
# ------------------------------------
CHPW_DIRS=$HOME/.cache/shell/chpwd-recent-dirs; [ ! -e $CHPW_DIRS ] && touch $CHPW_DIRS
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file $CHPW_DIRS
zstyle ':chpwd:*' recent-dirs-pushd true


# ------------------------------------
# 履歴
# ------------------------------------
HISTFILE=~/.zsh_history

# メモリ上に保存される件数（検索できる件数）
HISTSIZE=100000
# ファイルに保存される件数
SAVEHIST=100000
# 履歴を複数の端末で共有する
setopt share_history
# 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_dups
# 重複するコマンドは古い方を削除する
setopt hist_ignore_all_dups
#メタ文字(*,[],?…)が含まれているとファイル名だと勘違いする問題を解決
setopt nonomatch

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
# dockerにloginする。第一引数：container NAME or container id, 第二引数：user name
# tmux 使用時にpaneの背景色が変わる。
alias docker-login='(){tmux select-pane -P "fg=default,bg=colour234"; docker exec -it $1 bash -lc "su - $2";tmux select-pane -P "fg=default,bg=default" }'
# tmux 使用時にpaneの背景色が変わる。それ以外は通常のsshと同様
alias ssh='(){tmux select-pane -P "fg=default,bg=colour232"; ssh $@; tmux select-pane -P "fg=default,bg=default"}'
# localhostのipを定数に保存
export LOCAL_HOST_IP=`ifconfig en0 | grep inet | grep -v inet6 | sed -E "s/inet ([0-9]{1,3}.[0-9]{1,3}.[0-9].{1,3}.[0-9]{1,3}) .*$/\1/" | tr -d "\t"`

# dockerコンテナIDをpecoで選択してプロンプトにinsertする
function anyframe-widget-insert-docker-ps() {
  docker ps | tail -n +2 \
  | anyframe-selector-auto \
  | cut -d" " -f1 \
  | anyframe-action-insert
}
zle -N anyframe-widget-insert-docker-ps
bindkey '^xd' anyframe-widget-insert-docker-ps

# ------------------------------------
# XQuartzを入れる
# ------------------------------------
export DISPLAY_MAC=`ifconfig en0 | grep "inet " | cut -d " " -f2`:0
function startx() {
  if [ -z "$(ps -ef|grep XQuartz|grep -v grep)" ] ; then
    open -a XQuartz
    socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
  fi
}
# ------------------------------------
# sshの接続先を^xsshで選択可能にする
# ├  conf.d
# │   ├ project1
# │   │     config
# │   │     project1_rsa
# │   └ project2
# │         config
# │         project2_rsa
# ├  config
# └  id_rsa
# ------------------------------------

function anyframe-widget-ssh () {
  awk '
    tolower($1)=="host" {
      for (i=2; i<=NF; i++) {
        if ($i !~ "[*?]") {
          printf $i
        }
      }
    }
    tolower($1)=="hostname" {
      for (i=2; i<=NF; i++) {
          print  " ("$i")"
      }
    }
    ' ~/.ssh/conf.d/*/config \
    | anyframe-selector-auto \
    | awk '{print $1}' \
    | anyframe-action-execute ssh
}
zle -N anyframe-widget-ssh
bindkey "^xssh" anyframe-widget-ssh
