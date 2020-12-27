#/bin/bash

sudo apt update && sudo apt upgrade
sudo apt -y install build-essential language-pack-ja-base language-pack-ja ibus-mozc git
sudo apt-get install build-essential curl file git
localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
