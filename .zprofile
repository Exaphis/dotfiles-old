case `uname` in
Darwin)
    eval $(/opt/homebrew/bin/brew shellenv)
    eval "$(pyenv init --path)"
    ;;
Linux)
    ;;
esac

# purdue server specific settings
if hostname | grep purdue.edu > /dev/null; then
    # set TERM variable to avoid terminal is not fully functional warnings
    export TERM='xterm-256color'

    # strip permissions from group and others
    umask 077

    # CS354 Xinu lab setup
    export PATH=${PATH}:/p/xinu/bin
    export CS_CLASS=cortex
fi
