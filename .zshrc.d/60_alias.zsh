
# dockerにloginする。第一引数：container NAME or container id, 第二引数：user name
# tmux 使用時にpaneの背景色が変わる。
alias docker-login='(){tmux select-pane -P "fg=default,bg=colour234"; docker exec -it $1 bash -lc "sudo su - $2";tmux select-pane -P "fg=default,bg=default" }'
# tmux 使用時にpaneの背景色が変わる。それ以外は通常のsshと同様
alias ssh='(){tmux select-pane -P "fg=default,bg=colour232"; ssh $@; tmux select-pane -P "fg=default,bg=default"}'
