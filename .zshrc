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
bindkey -v
zplug "plugins/git",   from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

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
alias tmux-copy='tmux save-buffer - | reattach-to-user-namespace pbcopy'

ZSH_THEME="robbyrussell"
