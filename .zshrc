export ZSH="/Users/salmanshaikh/.oh-my-zsh"

ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"
plugins=(
	z
	git
	sudo
	python
	compleat
	transfer
	archlinux
	nvm
	gitignore
	vi-mode
	zsh-autosuggestions
	zsh-syntax-highlighting
)


source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

alias vim="nvim"
alias cls="clear"
PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/salmannotkhan/.local/bin
eval "$(starship init zsh)"
export NVM_HOMEBREW=$(brew --prefix nvm)
zstyle ':omz:plugins:nvm' silent-autoload yes

nn ()
{
  if [[ -e .node-version ]]; then
    nvm use $(cat .node-version)
  elif [[ -e .nvmrc ]]; then
    nvm use $(cat .nvmrc)
  fi
}
add-zsh-hook chpwd nn
nn

source $HOME/.urw-tunnel
