### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

# zinit snippet OMZL::git.zsh

# Two regular plugins loaded without investigating.
zinit ice wait'1'; zinit light zsh-users/zsh-autosuggestions
zinit ice wait'1'; zinit light zdharma/fast-syntax-highlighting

# Plugin history-search-multi-word loaded with investigating.
zinit ice wait'1'; zinit load zdharma/history-search-multi-word

# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"
zinit light DFurnes/purer

# A glance at the new for-syntax – load all of the above
# plugins with a single command. For more information see:
# https://zdharma.org/zinit/wiki/For-Syntax/
# zinit for \
#     light-mode  zsh-users/zsh-autosuggestions \
#     light-mode  zdharma/fast-syntax-highlighting \
#                 zdharma/history-search-multi-word \
#     light-mode pick"async.zsh" src"pure.zsh" \
#                 DFurnes/purer

zinit ice wait'1'; zinit light "b4b4r07/enhancd"

# fzf を使ったウィジェットが複数バンドルされたプラグインです。
zinit ice wait'1'; zinit light "vintersnow/anyframe"
# Homebrew で git をインストールしていること、 `HOMEBREW_PREFIX` に Homebrew のプリフィックスが格納されている前提です。
# zinit snippet --command \
#     "/usr/local/share/git-core/contrib/diff-highlight/diff-highlight"

# ls よりも使いやすく見やすいディレクトリの一覧表示のコマンドを定義するプラグインです。
# zinit ice pick'k.sh'
# zinit light 'supercrabtree/k'
# # .zshrc を zcompile してロードしてくれる src コマンドを定義するプラグインです。
# zinit snippet 'OMZ::plugins/zsh_reload/zsh_reload.plugin.zsh'

compinit
zinit cdreplay -q

# コマンドをハイライトするプラグインを遅延ロードします。
# zinit ice wait'1' atload '_zsh_highlight'
# zinit light 'zdharma/fast-syntax-highlighting'
# コマンドをサジェストするプラグインを遅延ロードします。
# zinit ice wait'!0' atload '_zsh_autosuggest_start'
# zinit light 'zsh-users/zsh-autosuggestions'

# プロンプトのテーマを遅延ロードします。このプラグインのみロード完了後にプロンプトを再描画しています。
# PS1="LOADING ➜  ~ " # provide a nice prompt till the theme loads
# # zinit snippet OMZ::themes/robbyrussell.zsh-theme
# zinit ice wait'!0' notify
# zinit snippet OMZ::themes/robbyrussell.zsh-theme
# zinit light themes/robbyrussell.zsh-theme

zstyle ":anyframe:selector:" use fzf-tmux

# ------------------------------------
# oh-my-zshからテーマを設定
# ------------------------------------
# ZSH_THEME="robbyrussell"


# ------------------------------------
# cdr, add-zsh-hook を有効にする
# ------------------------------------
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# ------------------------------------
#  # cdr の設定
# ------------------------------------
CHPW_DIRS=$HOME/.cache/shell/chpwd-recent-dirs; [ ! -e $CHPW_DIRS ] && touch $CHPW_DIRS
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file $CHPW_DIRS
zstyle ':chpwd:*' recent-dirs-pushd true

