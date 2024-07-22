#!/bin/bash -e

printf "Setup script for Mac OS\n"
printf "Please read and install manually\n"
exit 1

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
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# packages
install_message "Installing Kegs 'n Casks"
brew_formulas=(bash iterm2 git azure-cli kubectl helm golang powerline-go jq wget)

for formula in "${brew_formulas[@]}"; do brew install "${formula}"; done

brew tap homebrew/cask-fonts
brew install --cask font-cascadia-code
brew install --cask font-cascadia-code-pl
brew install --cask font-cascadia-mono
brew install --cask font-cascadia-mono-pl

# change shell to bash (M1 brew formulas are install in /opt/homebrew/bin/)
sudo sh -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
chsh -s /opt/homebrew/bin/bash
