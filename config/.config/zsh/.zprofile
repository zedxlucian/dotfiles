# Profile file. Runs on login. Environmental variables are set here.

# Adds ~.local/bin to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"
export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"

# Default programs
export EDITOR="emacsclient -c"
export VISUAL="emacsclient -c"
export TERMINAL="st"
export BROWSER="firefox"
export TIME_STYLE="+%d-%m-%Y %H:%M:%S"
export COLORTERM="truecolor"
# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_LOCAL_HOME="$HOME/.local"

export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export LESSHISTFILE="-"
export DISPLAY=":0.0"

# Vagrant dependency compatibility fix
VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1

# FZF ENV
export FZF_DEFAULT_COMMAND="fd -H . '/etc' $HOME '/usr'"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#  --color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
#  --color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B
# '
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200' --select-1 --exit-0"

# Fontpreview ENV
export FONTPREVIEW_FONT_SIZE=14
# export FONTPREVIEW_BG_COLOR="#282A36"
# export FONTPREVIEW_FG_COLOR="#F8F8F2"

# Export XDG environmental variables from '~/.config/user-dirs.dirs'
eval "$(sed 's/^[^#].*/export &/g;t;d' ${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs)"

# Start graphical server on tty1 if not already running; This only works without display manager.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && startx "${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc" -- vt1 > $HOME/.local/share/xorg/Xorg.0.log 2>&1
