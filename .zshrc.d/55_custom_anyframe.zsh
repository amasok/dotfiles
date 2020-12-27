
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
    ' ~/.ssh/conf.d/*/config* \
    | anyframe-selector-auto \
    | awk '{print $1}' \
    | anyframe-action-execute ssh
}
zle -N anyframe-widget-ssh
bindkey "^xssh" anyframe-widget-ssh
