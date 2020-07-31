
if [ -d $HOME/.anyenv ]
then
    # vscodeでanyenvのpathを読み込んでくれないので読み込み順を変更する
    # https://dev.classmethod.jp/articles/anyenv-set-path-for-visual-studio-code/
		export PATH="$HOME/.anyenv/bin:$PATH"
		eval "$(anyenv init -)"
		for D in `ls $HOME/.anyenv/envs`
		do
		  export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
		done
fi

if [ -d $HOME/bin ]
then
    export PATH="$HOME/bin:$PATH"
fi
