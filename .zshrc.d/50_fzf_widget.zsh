# ------------------------------------
# fzfベースのウィジェット設定（anyframe置き換え）
# ------------------------------------

# cdr - recent directories
fzf-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-cdr
bindkey '^xb' fzf-cdr 

# ブランチ一覧 ⇒ 選択 ⇒ checkout
fzf-git-checkout() {
    local branch=$(git branch -a | grep -v HEAD | sed 's/^\*//' | sed 's/^ *//' | fzf --query "$LBUFFER")
    if [ -n "$branch" ]; then
        branch=$(echo "$branch" | sed 's#remotes/[^/]*/##')
        BUFFER="git checkout ${branch}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-git-checkout
bindkey '^x^b' fzf-git-checkout

# history ⇒ 選択 ⇒ 実行
fzf-history-exec() {
    local selected=$(history -n 1 | tail -r | fzf --query "$LBUFFER")
    if [ -n "$selected" ]; then
        BUFFER="${selected}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-history-exec
bindkey '^xr' fzf-history-exec
bindkey '^x^r' fzf-history-exec

# history ⇒ 選択 ⇒ コマンドラインに挿入
fzf-history-insert() {
    local selected=$(history -n 1 | tail -r | fzf --query "$LBUFFER")
    if [ -n "$selected" ]; then
        BUFFER="${selected}"
        CURSOR=$#BUFFER
    fi
    zle clear-screen
}
zle -N fzf-history-insert
bindkey '^xp' fzf-history-insert
bindkey '^x^p' fzf-history-insert

# ghq で管理してるリポジトリ一覧 ⇒ 選択 ⇒ 移動
fzf-ghq() {
    local selected_dir=$(ghq list -p | fzf --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-ghq
bindkey '^xg' fzf-ghq
bindkey '^x^g' fzf-ghq

# プロセス一覧 ⇒ 選択 ⇒ kill
fzf-kill-process() {
    local pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo $pid | xargs kill -${1:-9}
    fi
    zle clear-screen
}
zle -N fzf-kill-process
bindkey '^xk' fzf-kill-process
bindkey '^x^k' fzf-kill-process

# ブランチ一覧 ⇒ 選択 ⇒ コマンドラインに挿入
fzf-git-branch-insert() {
    local branch=$(git branch -a | grep -v HEAD | sed 's/^\*//' | sed 's/^ *//' | fzf --query "$LBUFFER")
    if [ -n "$branch" ]; then
        branch=$(echo "$branch" | sed 's#remotes/[^/]*/##')
        BUFFER="${BUFFER}${branch}"
        CURSOR=$#BUFFER
    fi
    zle clear-screen
}
zle -N fzf-git-branch-insert
bindkey '^xi' fzf-git-branch-insert
bindkey '^x^i' fzf-git-branch-insert

# ファイル名 ⇒ 選択 ⇒ コマンドラインに挿入
fzf-insert-filename() {
    local selected=$(find . -type f | fzf --query "$LBUFFER")
    if [ -n "$selected" ]; then
        BUFFER="${BUFFER}${selected}"
        CURSOR=$#BUFFER
    fi
    zle clear-screen
}
zle -N fzf-insert-filename
bindkey '^xf' fzf-insert-filename
bindkey '^x^f' fzf-insert-filename


# dockerコンテナIDをfzfで選択してプロンプトにinsertする
fzf-docker-ps-insert() {
  local container_id=$(docker ps | tail -n +2 | fzf | awk '{print $1}')
  if [ -n "$container_id" ]; then
    BUFFER="${BUFFER}${container_id}"
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N fzf-docker-ps-insert
bindkey '^xd' fzf-docker-ps-insert

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

fzf-ssh() {
  local selected=$(awk '
    tolower($1)=="host" {
      for (i=2; i<=NF; i++) {
        if ( ($i !~ "[*?]") || !($i !~ "[gw]")) {
          printf $i
        }
      }
    }
    tolower($1)=="hostname" {
      for (i=2; i<=NF; i++) {
          printf " ("$i")"
      }
    }
    $1=="" {
        print ""
    }
    ' ~/.ssh/conf.d/*/*config* 2>/dev/null | fzf | awk '{print $1}')
  if [ -n "$selected" ]; then
    BUFFER="ssh ${selected}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-ssh
bindkey "^xssh" fzf-ssh
