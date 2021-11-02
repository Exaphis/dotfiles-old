eval "$(starship init zsh)"

# base16-shell color scheme
# only needed to be run once
BASE16_SHELL="$HOME/.config/base16-shell/"
BASE16_SHELL_SET_BACKGROUND=false
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

base16_default-dark

# enable history saving
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=1000
setopt INC_APPEND_HISTORY_TIME

transfer () {
    curl "https://bashupload.com/`basename ${1}`" --data-binary "@${1}"
}

alias vi='vim'

# enable vi mode for the zsh line editor
bindkey -v
bindkey '^R' history-incremental-pattern-search-backward
bindkey -v '^?' backward-delete-char
bindkey -a '^L' clear-screen

# bare dotfiles setup
function config() {
    if [ "$1" = "status" ]; then
        git --git-dir=$HOME/.dotfiles --work-tree=$HOME status -uno
    elif [ "$1" = "status-all" ]; then
        git --git-dir=$HOME/.dotfiles --work-tree=$HOME status
    else
        git --git-dir=$HOME/.dotfiles --work-tree=$HOME $@
    fi
}

# OS-specific commands
case `uname` in
Darwin)
    ln -sf "$HOME/.config/kitty/kitty_macos.conf" "$HOME/.config/kitty/kitty.conf"

    alias ls='ls -G'  # colorful ls
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # jenv
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"

    # n
    export N_PREFIX="$HOME/n"
    export PATH="$HOME/bin:$N_PREFIX/bin:$PATH"  # ensure n's node is picked up first
    ;;
Linux)
    ln -sf "$HOME/.config/kitty/kitty_linux.conf" "$HOME/.config/kitty/kitty.conf"

    alias ls='ls --color=auto'  # colorful ls
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ;;
esac

