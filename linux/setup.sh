#!/bin/bash -e

# set the default shell to /bin/bash and update to pro theme for colors to match

install_message() {
    message="$1                                                                                             "
    blueBackground='\033[44m'
    RESET='\033[0m'
    printf "${blueBackground}--------------------------------------------------------------------------------------------------------------${RESET}\n"
    printf "${blueBackground}-                                            ${message:0:64}-${RESET}\n"
    printf "${blueBackground}--------------------------------------------------------------------------------------------------------------${RESET}\n"
}

# brew
# install_message "Installing Homebrew"
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# packages
# install_message "Installing Kegs 'n Casks"
# brew_formulas=(bash iterm2 postman git fontconfig azure-cli kubectl helm golang powerline-go jq dnsmasq ffmpeg gstreamer htop nmap telnet wget ngrok)

# for formula in "${brew_formulas[@]}"; do brew install "${formula}"; done

sudo snap install --classic k9s
sudo snap install --classic kubectl
sudo snap install --classic helm
sudo snap install --classic jq

sudo apt update
sudo apt upgrade -y
sudo apt install -y golang-go azure-cli fonts-cascadia-code

go install github.com/justjanne/powerline-go@latest

# change shell to bash (M1 brew formulas are install in /opt/homebrew/bin/)
sudo sh -c 'echo /usr/bin/bash >> /etc/shells'
chsh -s /usr/bin/bash

# setup bash profile
#currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#ln -sf "${currentDir}/.profile" ~/bash_profile
repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "source ${repo_dir}/linux/.bash_profile" >>~/.bash_profile

mkdir -p ~/.kube
