#!/usr/bin/env bash

printf "Setup script for Linux\n"
printf "Please read and install manually\n"
exit 1

arch="amd64"

install_message() {
    message="$1                                                                                             "
    blueBackground='\033[44m'
    RESET='\033[0m'
    printf "${blueBackground}--------------------------------------------------------------------------------------------------------------${RESET}\n"
    printf "${blueBackground}-                                            ${message:0:64}-${RESET}\n"
    printf "${blueBackground}--------------------------------------------------------------------------------------------------------------${RESET}\n"
}

sudo apt update
sudo apt upgrade -y

# microk8s
sudo snap install microk8s --classic --channel=latest/stable
sudo usermod -a -G microk8s $USER

# REBOOT

# kubernetes tools
# sudo snap install --classic kubectl # (installed with microk8s)
# sudo snap install --classic helm # (installed with microk8s)

mkdir -p ~/.kube
mkdir -p ~/.local/bin

# basic tools
sudo apt install -y curl nano build-essential openssh-server net-tools jq golang-go fontconfig fonts-cascadia-code

# azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# k9s
k9s_version="v0.32.5"
k9s_package="k9s_Linux_${arch}"
wget https://github.com/derailed/k9s/releases/download/${k9s_version}/${k9s_package}.tar.gz
tar -xf ${k9s_package}.tar.gz
mv k9s ${HOME}/.local/bin/k9s
rm ${k9s_package}.tar.gz

# manually install powerline-go
powerline_go_version="v1.24"
powerline_go_package="powerline-go-linux-${arch}"
curl -fsSLO https://github.com/justjanne/powerline-go/releases/download/${powerline_go_version}/${powerline_go_package}
chmod +x ${powerline_go_package}
mv ${powerline_go_package} ${HOME}/.local/bin/powerline-go

# copy bash profiles and aliases
curl -O "https://raw.githubusercontent.com/sseiber/computersetup/main/.bash_path_aliases.json"
curl -O "https://raw.githubusercontent.com/sseiber/computersetup/main/linux/.bash_aliases"
curl -O "https://raw.githubusercontent.com/sseiber/computersetup/main/linux/.bash_exports.json"
curl -O "https://raw.githubusercontent.com/sseiber/computersetup/main/linux/.bash_profile"
curl -O "https://raw.githubusercontent.com/sseiber/computersetup/main/linux/.bashrc"

# change shell to bash
sudo sh -c 'echo /usr/bin/bash >> /etc/shells'
chsh -s /usr/bin/bash
