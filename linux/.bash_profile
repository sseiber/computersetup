# See setup.sh in this folder for pre-requisites

export PATH=$HOME/.local/bin:{$PATH}:/usr/local/go/bin
export LBC_USE_POWERLINE=true

[[ -f ~/.bashrc ]] && {
    . ~/.bashrc
}
