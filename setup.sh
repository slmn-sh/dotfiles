#!/bin/bash

if [[ uname == 'Darwin' ]]; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Brewing packages"
    brew install python npm nodejs neovim fd ripgrep stow
else
    echo "Installinng packages"
    sudo pacman -S --noconfirm zsh npm nodejs neovim fd ripgrep stow
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

echo "Installing codicon fonts (for vim icons)"
mkdir -p ~/.local/share/fonts/Microsoft/TrueType
curl -fsSL "https://microsoft.github.io/vscode-codicons/dist/codicon.ttf" -o ~/.local/share/fonts/Microsoft/TrueType/codicon_Regular.ttf
fc-cache -f
