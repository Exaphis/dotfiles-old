eval "$(starship init zsh)"

alias ls='ls --color=auto'  # colorful ls

# base16-shell color scheme
# only needed to be run once
BASE16_SHELL="$HOME/.config/base16-shell/"
BASE16_SHELL_SET_BACKGROUND=false
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# enable history saving
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=1000
setopt INC_APPEND_HISTORY_TIME

transfer () {
    curl "https://bashupload.com/`basename ${1}`" --data-binary "@${1}"
}

bindkey '^R' history-incremental-pattern-search-backward
bindkey -v '^?' backward-delete-char
bindkey -a '^L' clear-screen

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
