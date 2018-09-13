#!/bin/bash

set -u
DOT_DIRECTORY="${HOME}/dotfiles"
DOT_CONFIG_DIRECTORY=".config"

echo "link home directory dotfiles"
cd ${DOT_DIRECTORY}
for f in .??*
do
    #無視したいファイルやディレクトリ
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitignore" ] && continue
    [ "$f" = ".config" ] && continue
    ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
    echo "source dir ${DOT_DIRECTORY}/${f}"

done

# echo "link .config directory dotfiles"
# cd ${DOT_DIRECTORY}/${DOT_CONFIG_DIRECTORY}
# for file in `\find . -maxdepth 8 -type f`; do
# #./の2文字を削除するためにfile:2としている
#     ln -snfv ${DOT_DIRECTORY}/${DOT_CONFIG_DIRECTORY}/${file:2} ${HOME}/${DOT_CONFIG_DIRECTORY}/${file:2}
#     #echo "source dir ${DOT_DIRECTORY}/${DOT_CONFIG_DIRECTORY}/${file:2}"
#     #echo "dist dir ${HOME}/${DOT_CONFIG_DIRECTORY}/${file:2}"
# done
#
# #xkeysnail link
# sudo mkdir -p /etc/opt/xkeysnail/
# sudo ln -snfv ${DOT_DIRECTORY}/start_xkeysnail.sh /etc/opt/xkeysnail/start_xkeysnail.sh
# sudo ln -snfv ${DOT_DIRECTORY}/xkeysnail_config.py /etc/opt/xkeysnail/xkeysnail_config.py

echo "linked dotfiles complete!"
