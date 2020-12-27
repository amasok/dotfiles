
if [ -d $HOME/.anyenv ]
then
    # # vscodeでanyenvのpathを読み込んでくれないので読み込み順を変更する
    # # https://dev.classmethod.jp/articles/anyenv-set-path-for-visual-studio-code/
		# export PATH="$HOME/.anyenv/bin:$PATH"
		# eval "$(anyenv init -)"
		# for D in `ls $HOME/.anyenv/envs`
		# do
		  # export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
		# done
    export PATH="$HOME/.anyenv/bin:$PATH"
    export ANYENV_ROOT="$HOME/.anyenv/bin/anyenv"
    if [ -d $ANYENV_ROOT ]; then
      export PATH="$ANYENV_ROOT/bin:$PATH"
      for D in `command ls $ANYENV_ROOT/envs`
      do
        export PATH="$ANYENV_ROOT/envs/$D/shims:$PATH"
      done
    fi

    function anyenv_init() {
      eval "$(anyenv init - --no-rehash)"
    }
    function anyenv_unset() {
      unset -f ndenv
      unset -f rbenv
    }
    function ndenv() {
      anyenv_unset
      anyenv_init
      ndenv "$@"
    }
    function rbenv() {
      anyenv_unset
      anyenv_init
      rbenv "$@"
    }
fi

if [ -d $HOME/bin ]
then
    export PATH="$HOME/bin:$PATH"
fi
