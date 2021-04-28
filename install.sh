#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

install_packages() {
    if ! command_exists zsh; then
        echo "Installing zsh ..."
        sudo apt install zsh
    fi

    if ! command_exists git; then
        echo "Installing git ..."
        sudo apt install git
    fi

    if ! command_exists wget; then
        echo "Installing wget ..."
        sudo apt install wget
    fi
}

install_dependencies() {
    echo "Install autosuggestions plugin"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    echo "Install syntax-highlighting plugin"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

install_packages

echo "Installing Oh My Zsh"
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

install_dependencies

echo "Updating the ~/.zshrc file"
cp ${SCRIPT_DIR}/.zshrc ~/.zshrc

echo "Setting zsh as default shell"
chsh -s $(which zsh)

echo "\nOh My Zsh installation done !"
echo "Please reboot to finish installation."