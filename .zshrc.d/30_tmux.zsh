
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

