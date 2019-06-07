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
