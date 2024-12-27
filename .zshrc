export ZSH="$HOME/.oh-my-zsh"
export NVM_HOMEBREW=$(brew --prefix nvm)
export EDITOR="nvim"

ZSH_THEME="robbyrussell"

plugins=(
    z
    git
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
alias vi="nvim"
alias start="~/sessionizer.sh"

source $ZSH/oh-my-zsh.sh

# sst
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

. "$HOME/.cargo/env"

# sst
export PATH=/Users/salmannotkhan/.sst/bin:$PATH
