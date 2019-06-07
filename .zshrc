ZSHHOME="${HOME}/.zshrc.d"

if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

CUSTOM_ZSHHOME="${HOME}/.zshrc.d/custom.d"

if [ -d $CUSTOM_ZSHHOME -a -r $CUSTOM_ZSHHOME -a \
     -x $CUSTOM_ZSHHOME ]; then
    for i in $CUSTOM_ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi
