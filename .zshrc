export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gozilla"

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  git
  zoxide
)

source $ZSH/oh-my-zsh.sh

alias gf=gf

. "$HOME/.local/bin/env"

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

  alias ls='ls --color=auto'
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi

# 用于切换node版本
FNM_PATH="/home/jz/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi
