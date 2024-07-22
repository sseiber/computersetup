# pre-requisites:
#
#  install homebrew:
#  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
#
#  install brew packages:
#    brew_formulas=(bash iterm2 coreutils azure-cli kubectl helm golang powerline-go google-chrome jq)
#    for formula in "${brew_formulas[@]}"; do brew install "${formula}"; done
#
#  change shell to bash:
#    sudo sh -c 'echo /usr/local/bin/bash >> /etc/shells'
#    chsh -s /usr/local/bin/bash
#
#  install cascadia code font:
#    brew install --cask font-cascadia-code font-cascadia-code-pl  font-cascadia-mono font-cascadia-mono-pl

# these exports are required here before .bashrc is processed
# other general purpose exports are defined in bash_exports.json
export BREWPATH=/opt/homebrew
export PATH=$BREWPATH/sbin:$BREWPATH/bin:${HOME}/.local/bin:${PATH}

#export SSH_AUTH_SOCK=~/.ssh/ssh-agent.$HOSTNAME.sock
#ssh-add -l 2>/dev/null >/dev/null
#if [ $? -ge 2 ]; then
#  ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
#fi

[[ -f ~/.bashrc ]] && {
    . ~/.bashrc
}
