ZSHHOME="${HOME}/.zshrc.d"
export PATH="$HOME/bin:$PATH"
export HOMEBREW_PREFIX="/usr/local"
if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

bindkey -e

CUSTOM_ZSHHOME="${HOME}/.zshrc.d/custom.d"

if [ -d $CUSTOM_ZSHHOME -a -r $CUSTOM_ZSHHOME -a \
     -x $CUSTOM_ZSHHOME ]; then
    for i in $CUSTOM_ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

if [ $DOTFILES/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/bzip2/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="/usr/local/opt/krb5/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
