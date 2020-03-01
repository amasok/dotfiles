#/bin/bash

declare -a info=($(./bin/get_os_info.sh))

case ${info[0]} in
ubuntu)
    echo "ubuntu"
    /bin/bash -c ./init.d/install_apt.sh

    # if [[ ${info[1]} == "x86_64" ]]; then
    #     echo x86_64
    # fi
    ;;
mac)
    echo 'mac install by brew.'
   # brew系のインストール
    /bin/bash -c ./init.d/install_brew.sh
    ;;
*)
    echo "unsupported"
    ;;
esac


# vim pluginをインストール
/bin/bash -c ./scripts/link.sh
/bin/bash -c ./scripts/vimrc.sh
