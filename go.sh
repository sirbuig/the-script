#!/bin/zsh

sudo apt update -y && sudo apt upgrade -y

echo "Downloading the installer file..."

wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz
DIR="/usr/local/go"
if [ -d "$DIR" ]; then
    sudo rm -rf /usr/local/go
fi

sudo tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz

sudo rm -rf go1.23.1.linux-amd64.tar.gz

cat << EOF >> ~/.zshrc
export GOROOT=/usr/local/go
export GOPATH=\$HOME/go
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH
EOF

source ~/.zshrc
