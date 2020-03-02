#/bin/bash

# https://qiita.com/pygo/items/a280f2947b8a6b0c5f23


sudo apt install docker.io -y
sudo useradd dockremap
sudo touch /etc/docker/daemon.json

json=$(cat << EOS
{
    "userns-remap": "default"
}
EOS
)

sudo cat $json >> /etc/docker/daemon.json
sudo service docker restart
sudo docker info | grep "Docker Root Dir:"

# sudo せずにdockerを使う
sudo usermod -aG docker amasok
su -l amasok
