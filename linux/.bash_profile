# See setup.sh in this folder for pre-requisites

export PATH=${PATH}:$HOME/.local/bin:/usr/local/go/bin:$HOME/go/bin
export LBC_USE_POWERLINE=true

[[ -f ~/.bashrc ]] && {
    . ~/.bashrc
}
