export ZSH="/Users/salmannotkhan/.oh-my-zsh"

ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins=(
	z
	git
	sudo
	python
	compleat
	transfer
	nvm
	macos
	gitignore
	vi-mode
	zsh-autosuggestions
	zsh-syntax-highlighting
	evalcache
)


source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

alias vim="nvim"
alias cls="clear"
alias start="~/sessionizer.sh"
PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/salmannotkhan/.local/bin
export NVM_HOMEBREW=$(brew --prefix nvm)
zstyle ':omz:plugins:nvm' silent-autoload yes

_evalcache starship init zsh
_evalcache pyenv init -
_evalcache pyenv virtualenv-init -

nn ()
{
  if [[ -e .node-version ]]; then
    nvm use $(cat .node-version)
  elif [[ -e .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd nn
nn

# bun completions
[ -s "/Users/salmannotkhan/.bun/_bun" ] && source "/Users/salmannotkhan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
