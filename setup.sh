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

# Install external plugins and themes
echo "Installing external plugins and themes..."

# powerlevel10k theme
if [ ! -d "$ZSH/custom/themes/powerlevel10k" ]; then
    echo "Installing powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH/custom/themes/powerlevel10k"
fi

# zsh-syntax-highlighting plugin
if [ ! -d "$ZSH/custom/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH/custom/plugins/zsh-syntax-highlighting"
fi

# you-should-use plugin
if [ ! -d "$ZSH/custom/plugins/you-should-use" ]; then
    echo "Installing you-should-use plugin..."
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH/custom/plugins/you-should-use"
fi

# zsh-vi-mode plugin
if [ ! -d "$ZSH/custom/plugins/zsh-vi-mode" ]; then
    echo "Installing zsh-vi-mode plugin..."
    git clone https://github.com/jeffreytse/zsh-vi-mode.git "$ZSH/custom/plugins/zsh-vi-mode"
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
