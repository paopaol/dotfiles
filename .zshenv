path_dirs=(
  /opt/cmake-3.28.3-linux-x86_64/bin
  /opt/nvim-linux-x86_64/bin
  $PATH
  $HOME/go/bin
  /home/jz/workspace/jz/clice/bin
)

typeset -U -x PATH path_dirs
PATH="${(j.:.)path_dirs}"
. "$HOME/.cargo/env"

export CLAUDE_CODE_EFFORT_LEVEL=max
##export TERM=alacritty
export TERM=xterm-256color
export COLORTERM=truecolor
export ALACRITTY_WSL2_FIX=true
