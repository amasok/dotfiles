
# dockerにloginする。第一引数：container NAME or container id, 第二引数：user name
# tmux 使用時にpaneの背景色が変わる。
alias docker-login='(){tmux select-pane -P "fg=default,bg=colour234"; docker exec -it $1 bash -lc "sudo su - $2";tmux select-pane -P "fg=default,bg=default" }'
# tmux 使用時にpaneの背景色が変わる。それ以外は通常のsshと同様
# window全体に適用されるのでsshしたい場合は別window立ち上げて実行する運用
alias ssh='(){
    tmux set window-style "bg=colour232";
    tmux set window-active-style "bg=colour232";
    ssh $@;
    tmux set window-style "bg=colour239";
    tmux set window-active-style "bg=colour234";
}'

alias ctags='/usr/local/bin/ctags'
