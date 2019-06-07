
# ------------------------------------
# XQuartzを入れる
# ------------------------------------
export DISPLAY_MAC=`ifconfig en0 | grep "inet " | cut -d " " -f2`:0
function startx() {
  if [ -z "$(ps -ef|grep XQuartz|grep -v grep)" ] ; then
    open -a XQuartz
    socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
  fi
}

