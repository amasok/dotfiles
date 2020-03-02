
if [ -d $HOME/.anyenv ]
then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi

if [ -d $HOME/bin ]
then
    export PATH="$HOME/bin:$PATH"
fi
