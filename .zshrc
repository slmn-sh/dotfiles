export ZSH="$HOME/.oh-my-zsh"
export NVM_HOMEBREW=$(brew --prefix nvm)
export EDITOR="nvim"

ZSH_THEME="robbyrussell"

plugins=(
    z
    git
    python
    compleat
    nvm
    macos
    gitignore
    vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
    evalcache
)

zstyle ":omz:plugins:nvm" autoload yes
zstyle ":omz:plugins:nvm" silent-autoload yes
zstyle ":omz:plugins:nvm" lazy yes

alias vim="nvim"
alias start="~/sessionizer.sh"

source $ZSH/oh-my-zsh.sh

_evalcache pyenv init -
_evalcache pyenv virtualenv-init -
