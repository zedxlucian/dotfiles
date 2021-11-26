# System fetching tool
echo "" && neofetch

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"

# History setup
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_CACHE_HOME/zsh/history"
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSHVERSION"

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

export KEYTIMEOUT=1

# Default editor for remote connections
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacs'
else
  export EDITOR='emacs'
fi

#AUTO-COMPLETION!!
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Bind CTRL+SPACE to accept auto-suggestions.
bindkey '^ ' autosuggest-accept

#Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# FZF Keybinding.
source /usr/share/fzf/key-bindings.zsh
bindkey '^R' fzf-history-widget

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Install packages using yay
function in() {
    yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}'| xargs -ro yay -S
}

# Remove installed packages
function re() {
    yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
}

# GPG pinentry config
# export GPG_TTY=$(tty)
# gpg-connect-agent updatestartuptty /bye >/dev/null

# gpgconf --launch gpg-agent
