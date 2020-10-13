# Profile file. Runs on login. Environmental variables are set here.

# Adds ~.local/bin to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"
export PATH="$PATH:$HOME/.emacs.d/bin"

# Default programs
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"
export TERMINAL="st"
export BROWSER="firefox"

export TIME_STYLE="+%d-%m-%Y %H:%M:%S"

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_LOCAL_HOME="$HOME/.local"

export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export TMUX_TMPDIR="${XDG_RUNTIME_DIR:-/run/user/1000}"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export LESSHISTFILE="-"
export DISPLAY=":0.0"

# FZF ENV
export FZF_DEFAULT_COMMAND="fd -H . '/etc' $HOME '/usr'"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

# Export XDG environmental variables from '~/.config/user-dirs.dirs'
eval "$(sed 's/^[^#].*/export &/g;t;d' ${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs)"

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && startx "${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc" -- vt1 > $HOME/.local/share/xorg/Xorg.0.log 2>&1
