#!/bin/sh

function confirm {
    # Asks to confirm a statement.
    # First argument overrides default statement.
    # Returns 1 if user typed y or Y, 0 if anything else.
    local statement=$([ -z "$1" ] && printf "Confirm." || printf "$1")
    statement+=" (Y/N): "

    # Read one char from STDIN. Repeat until it's "Y" or "N" (caps insensitive)
    # By default, input from read is stored in $REPLY.
    REPLY=""
    while (( $(expr match "$REPLY" '[yYnN]') < 1 ))
    do
        read -N1 -p "$statement"
        echo # read doesn't print a newline character after the input
    done

    # if reply is "Y" or "y" we return a positive outcome
    if (( $(expr match "$REPLY" '[yY]') )); then
        return 1
    fi

    return 0
}

function echogreen {
    echo -e "\033[0;32m${1}\033[0m"
}

function echored {
    echo -e "\033[0;31m${1}\033[0m"
}

function usage {
    
    local n=$(basename $0)

    echo
    echo
    echo "  Dotfile and config installer"
    echo
    echo
    echo "  usage: $n [-h] [--help]"
    echo "         $n [package]"
    echo
    echo "  available packages:"
    echo "      vim -- symlink .vimrc and, optionally, install Vundle and Vim plugins."
    echo
    exit 0
}

# Run scripts depending on first arg.
# if no or invalid arg is provided, print help message.
if [[ ! $1 || "$1" = "-h" || "$1" = "--help" ]]; then usage; fi

# Absolute path this script is in
# https://stackoverflow.com/a/1638397
SCRIPTPATH=$(dirname $(readlink -f "$0"))

function vim_dotfiles {

    local src=$SCRIPTPATH/vim
    local dest=$HOME

    local vim_installed=1
    local vundle_installed=1

    local vimrc=$HOME/.vimrc
    local vimrc_backup=$HOME/.vimrc-old

    # Check if Vim is installed. Exit if not.
    if ! $(which vim &>/dev/null); then
        echored "Vim doesn't seem to be installed."
        vim_installed=0
    fi

    # If Vim is installed, check if Vundle is installed. If not, offer to install it.
    if (( $vim_installed )) && [[ ! -d $HOME/.vim/bundle/Vundle.vim ]]; then
        confirm "Vundle doesn't seem to be installed. Install?"
        if (( $? )); then
            # Install Vundle as per instructions on https://github.com/VundleVim/Vundle.vim
            git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
            echogreen "Vundle installed!"
        else vundle_installed=0
        fi
    fi

    # .vimrc exists and is not empty.
    if (( $vim_installed )) && [[ -s $vimrc ]]; then
        confirm ".vimrc exists. Back it up?"
        if (( $? )); then
            # Install Vundle as per instructions on https://github.com/VundleVim/Vundle.vim
            cp $vimrc $vimrc_backup && echogreen ".vimrc backed up to $vimrc_backup!"
        fi
    fi

    # Symlink .vimrc
    ln -fs $src/.vimrc $vimrc && echogreen ".vimrc symlinked!"

    # If Vim and Vundle are installed, offer to install plugins
    if (( $vim_installed && $vundle_installed )); then
        confirm "Install plugins?"
        if (( $? )); then
            vim -c PluginInstall
            echogreen "Plugin installation complete!"
        fi
    fi
}

case $1 in
    vim) vim_dotfiles;;
esac

exit 0

