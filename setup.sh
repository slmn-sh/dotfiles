#!/bin/bash

if [[ uname == 'Darwin' ]]; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Brewing packages"
    brew install python npm nodejs neovim fd ripgrep stow font-fira-code-nerd-font
else
    echo "Installing packages"
    sudo pacman -S --noconfirm zsh npm nodejs neovim fd ripgrep stow ttf-firacode-nerd alacritty
    chsh -s $(which zsh)
fi

echo "Creating symlinks"
stow -d ~/dotfiles -t ~/.config/ config --ignore=.DS_Store

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZSH_PLUGINS=("MichaelAquilina/zsh-autoswitch-virtualenv" "zsh-users/zsh-autosuggestions" "zsh-users/zsh-syntax-highlighting")

echo "Installing zsh plugings"

for PLUGIN in "${ZSH_PLUGINS[@]}";
do
    echo "${PLUGIN##*/}"
    git clone "https://github.com/${PLUGIN}.git" "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}plugins/${PLUGIN##*/}"
done
