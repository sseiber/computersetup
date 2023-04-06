# pre-requisites:
#
#  install homebrew:
#  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
#
#  install packages:
#    sudo snap install --classic k9s
#    sudo snap install --classic kubectl
#    sudo snap install --classic helm
#    sudo snap install --classic jq
#
#    sudo apt update
#    sudo apt upgrade -y
#    sudo apt install -y golang-go azure-cli fonts-cascadia-code
#
#    go install github.com/justjanne/powerline-go@latest
#
#  change shell to bash:
#    sudo sh -c 'echo /usr/local/bin/bash >> /etc/shells'
#    chsh -s /usr/local/bin/bash

export PATH=${PATH}:/usr/local/go/bin:~/go/bin
export LBC_USE_POWERLINE=true

[[ -f ~/.bashrc ]] && {
    . ~/.bashrc
}
