# Profile file. Runs on login. Environmental variables are set here.

# Adds ~.local/bin to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"
export PATH="$PATH:$HOME/.emacs.d/bin"

# Default programs
export EDITOR="emacs"
export VISUAL="emacs"
export TIME_STYLE="+%d-%m-%Y %H:%M:%S"
export COLORTERM="truecolor"
# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_LOCAL_HOME="$HOME/.local"

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export LESSHISTFILE="-"


# FZF ENV
export FZF_DEFAULT_COMMAND="fd -H . '/etc' $HOME '/usr'"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#  --color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
#  --color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B
# '
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200' --select-1 --exit-0"


# Export XDG environmental variables from '~/.config/user-dirs.dirs'
eval "$(sed 's/^[^#].*/export &/g;t;d' ${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs)"
