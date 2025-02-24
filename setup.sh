#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
	echo "err: missing repo at $DOTFILES_DIR"
	exit 1
fi

git -C "$DOTFILES_DIR" submodule update --init --recursive

ZSH="$HOME/.oh-my-zsh"

if [ ! -d "$ZSH/plugins" ]; then
    echo "err: $ZSH/plugins does not exist"
    exit 1
fi

#zsh-vi-mode
if [ ! -d "$ZSH/plugins/zsh-vi-mode" ]; then
    echo "Installing zsh-vi-mode plugin..."
    git clone https://github.com/jeffreytse/zsh-vi-mode.git "$ZSH/plugins/zsh-vi-mode"
fi

DOTFILES=(
	.zshrc
	.vimrc
	.zshenv
	.zprofile
	.ideavimrc
	.gitconfig
	.config/nvim/init.vim
	.tmux.conf
)

alias dotfiles='/usr/bin/git --git-dir=$DOTFILES_DIR --work-tree=$HOME'

dotfiles checkout
dotfiles config --local statues.showUntrackedFiles no

for file in "${DOTFILES[@]}"; do
    SRC="$DOTFILES_DIR/$file"
    DEST="$HOME/$file"

	# backup existing
    if [ -e "$DEST" ]; then
        mv "$DEST" "$DEST.backup"
    fi

    mkdir -p "$(dirname "$DEST")" # create destination

    ln -s "$SRC" "$DEST"
    echo "Symlinked $file"
done
