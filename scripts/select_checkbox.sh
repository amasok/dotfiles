#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
#メニュー
options[0]="basic install"
options[1]="tmux zsh vimrc settings Symbolic link"
options[2]="source vimrc"

#各メニューごとに挙動を記述する
function DOIT {
    if [[ ${choices[0]} ]]; then
        echo "basic install"
        /bin/bash $SCRIPT_DIR/../init.d/install
    fi

    if [[ ${choices[1]} ]]; then
        echo "tmux zsh vimrc settings Symbolic link"
# vim pluginをインストール
        /bin/bash $SCRIPT_DIR/link.sh
    fi

    if [[ ${choices[2]} ]]; then
        echo "source vimrc"
        /bin/bash $SCRIPT_DIR/vimrc.sh
    fi
}

clear

#現在フォーカスしているメニュー
current_line=0

source $SCRIPT_DIR/../.zshrc.d/select_menu.zsh

SELECT_LOOP
DOIT
