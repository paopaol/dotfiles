# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# execute genie -s for systemd service env
/usr/bin/genie -s


alias la='ls -la'
export nsea=~/workspace/nsea

source scl_source enable rh-nodejs14
source scl_source enable rh-python38
source scl_source enable llvm-toolset-7.0
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
source "$HOME/.cargo/env"
eval "$(starship init bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"
