source ~/.zplug/init.zsh

# ------------------------------------
# zplugの定義
# ------------------------------------
# ここにプラグインを定義する
zplug "themes/robbyrussell", from:oh-my-zsh, nice:19
zplug 'zsh-users/zsh-autosuggestions' # 入力中のコマンドをコマンド履歴から推測し、候補として表示する
zplug 'zsh-users/zsh-completions' # 候補選択拡張
zplug 'zsh-users/zsh-syntax-highlighting' #シンタックスエラーを色で表示
zplug "b4b4r07/http_code", as:command, use:bin
#zplug "b4b4r07/zsh-vimode-visual", use:"*.sh"
# bindkey -v
zplug "plugins/git",   from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "mollifier/anyframe"
zplug "b4b4r07/enhancd", use: enhancd.sh



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
if [ $SHLVL > 1 ]; then
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
bindkey '^x^b' anyframe-widget-checkout-git-branch

bindkey '^xr' anyframe-widget-execute-history
bindkey '^x^r' anyframe-widget-execute-history

bindkey '^xp' anyframe-widget-put-history
bindkey '^x^p' anyframe-widget-put-history

bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^x^g' anyframe-widget-cd-ghq-repository

bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill

bindkey '^xi' anyframe-widget-insert-git-branch
bindkey '^x^i' anyframe-widget-insert-git-branch

bindkey '^xf' anyframe-widget-insert-filename
bindkey '^x^f' anyframe-widget-insert-filename

# ------------------------------------
# cdr, add-zsh-hook を有効にする
# ------------------------------------
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# ------------------------------------
#  # cdr の設定
# ------------------------------------
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
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

# 重複するコマンドは古い法を削除する
setopt hist_ignore_all_dups
