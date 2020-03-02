#/bin/bash

sudo apt update && sudo apt upgrade
sudo apt -y install language-pack-ja-base language-pack-ja ibus-mozc git
localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
