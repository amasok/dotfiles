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
