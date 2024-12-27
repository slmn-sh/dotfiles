#!/bin/bash

if [[ "$(uname)" == 'Darwin' ]]; then
    brew tap homebrew/cask-fonts
    echo "Brewing packages"
    brew install npm nodejs neovim fd ripgrep stow font-fira-code-nerd-font ghostty
else
    echo "Installing packages"
    sudo pacman -S --noconfirm zsh npm nvm neovim fd ripgrep stow ttf-firacode-nerd ghostty
    chsh -s $(which zsh)
fi

echo "Creating symlinks"
stow -d ~/dotfiles -t ~/.config/ config --ignore=.DS_Store
exit

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZSH_PLUGINS=("MichaelAquilina/zsh-autoswitch-virtualenv" "zsh-users/zsh-autosuggestions" "zsh-users/zsh-syntax-highlighting")

echo "Installing zsh plugings"

for PLUGIN in "${ZSH_PLUGINS[@]}";
do
    echo "${PLUGIN##*/}"
    git clone "https://github.com/${PLUGIN}.git" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/${PLUGIN##*/}"
done
