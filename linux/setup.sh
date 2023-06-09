#!/usr/bin/env bash

install_message() {
    message="$1                                                                                             "
    blueBackground='\033[44m'
    RESET='\033[0m'
    printf "${blueBackground}--------------------------------------------------------------------------------------------------------------${RESET}\n"
    printf "${blueBackground}-                                            ${message:0:64}-${RESET}\n"
    printf "${blueBackground}--------------------------------------------------------------------------------------------------------------${RESET}\n"
}

sudo snap install --classic kubectl
sudo snap install --classic helm
sudo snap install --classic jq

sudo apt update
sudo apt upgrade -y

# install azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "TODO: Remember to install k9s"
# wget https://github.com/derailed/k9s/releases/download/v0.27.3/k9s_Linux_amd64.tar.gz
# tar -xf k9s_Linux_amd64.tar.gz

sudo apt install -y golang-go fontconfig fonts-cascadia-code build-essential openssh-server net-tools

# manually install powerline-go
curl -fsSLO https://github.com/justjanne/powerline-go/releases/download/v1.23/powerline-go-linux-amd64; chmod +x powerline-go-linux-amd64; mv powerline-go-linux-amd64 ${HOME}/.local/bin/powerline-go
# go install github.com/justjanne/powerline-go@latest

# change shell to bash
sudo sh -c 'echo /usr/bin/bash >> /etc/shells'
chsh -s /usr/bin/bash

# setup bash profile
#currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#ln -sf "${currentDir}/.profile" ~/bash_profile
repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "source ${repo_dir}/linux/.bash_profile" >>~/.bash_profile

mkdir -p ~/.kube
