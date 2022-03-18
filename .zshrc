# instead of sourcing .zshrc, use `znap restart`!

# install znap
[[ -f ~/zsh-snaps/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/zsh-snaps/zsh-snap

source ~/zsh-snaps/zsh-snap/znap.zsh

# display prompt
if type "starship" > /dev/null; then
    znap eval starship 'starship init zsh --print-full-init'
else
    export PS1="%F{green}%n@%m%f:%F{blue}%~%f%(?..%F{red})$%f "
fi

znap prompt

# Base16 shell initialization
BASE16_SHELL="$HOME/.config/base16-shell/"
BASE16_SHELL_SET_BACKGROUND=false
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

if type "base16_default-dark" > /dev/null; then
    base16_default-dark
fi

# enable history saving
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# allow cd without typing cd
setopt AUTO_CD

transfer () {
    curl "https://bashupload.com/`basename ${1}`" --data-binary "@${1}"
}

alias vi='vim'

# enable vi mode for the zsh line editor
bindkey -v
bindkey '^R' history-incremental-search-backward
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

# home-specific plugins
if [[ -v ZSH_HOME ]]; then
    znap source marlonrichert/zsh-autocomplete
    znap source zsh-users/zsh-syntax-highlighting
    zstyle ':autocomplete:*' min-input 1
fi

# OS-specific commands
case `uname` in
Darwin)
    ln -sf "$HOME/.config/kitty/kitty_macos.conf" "$HOME/.config/kitty/kitty.conf"

    alias ls='ls -G'  # colorful ls

    # jenv
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"

    # n
    export N_PREFIX="$HOME/n"
    export PATH="$HOME/bin:$N_PREFIX/bin:$PATH"  # ensure n's node is picked up first

    # pyenv
    eval "$(pyenv init -)"
    alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
    ;;
Linux)
    alias ls='ls --color=auto'  # colorful ls

    # only enable on Linux home system
    if [[ -v ZSH_HOME ]]; then
        ln -sf "$HOME/.config/kitty/kitty_linux.conf" "$HOME/.config/kitty/kitty.conf"
        alias open='detach xdg-open'
    fi

    # print irssi unread messages (fnotify)
    irc_msgs="$HOME/.irssi/fnotify"
    if [[ -f "$irc_msgs" ]]; then
        echo ""
        if [[ -s "$irc_msgs" ]]; then
            echo "There are $(cat "$irc_msgs" | wc -l | awk '{$1=$1;print}') unread IRC messages."
            echo -n "" > "$irc_msgs"
        else
            echo "There are no unread IRC messages."
        fi
    fi
    ;;
esac

