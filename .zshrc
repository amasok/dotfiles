ZSHHOME="${HOME}/.zshrc.d"
export PATH="$HOME/dotfiles/bin:$PATH"
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

# function precmd() {
#   if [ ! -z $TMUX ]; then
#     tmux refresh-client -S
#   else
#     dir="%F{cyan}%K{black} %~ %k%f"
#     if git_status=$(git status 2>/dev/null ); then
#       git_branch="$(echo $git_status| awk 'NR==1 {print $3}')"
#        case $git_status in
#         *Changes\ not\ staged* ) state=$'%{\e[30;48;5;013m%}%F{black} ± %f%k' ;;
#         *Changes\ to\ be\ committed* ) state="%K{blue}%F{black} + %k%f" ;;
#         * ) state="%K{green}%F{black} ✔ %f%k" ;;
#       esac
#       if [[ $git_branch = "master" ]]; then
#         git_info="%K{black}%F{blue}⭠ ${git_branch}%f%k ${state}"
#       else
#         git_info="%K{black}⭠ ${git_branch}%f ${state}"
#       fi
#     else
#       git_info=""
#     fi
#   fi
# }

tmux_automatically_attach_session

if [ $DOTFILES/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/ruby/bin:$PATH"

# if [ -d $HOME/.anyenv ] ; then
#   export PATH="$HOME/.anyenv/bin:$PATH"
#   eval "$(anyenv init -)"
#   for D in `\ls $HOME/.anyenv/envs`
#   do
#     export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
#   done
# fi
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/bzip2/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="/usr/local/opt/krb5/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
