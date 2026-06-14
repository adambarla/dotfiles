#!/bin/bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "err: missing repo at $DOTFILES_DIR"
    exit 1
fi

# We only need git to manage/download plugins
if ! command -v git >/dev/null 2>&1; then
    echo "err: git is required to set up the shell plugins"
    exit 1
fi

# Initialize/update submodule if .oh-my-zsh is tracked as a submodule
git -C "$DOTFILES_DIR" submodule update --init --recursive

ZSH="$DOTFILES_DIR/.oh-my-zsh"

if [ ! -d "$ZSH/plugins" ]; then
    echo "err: $ZSH/plugins does not exist. Ensure .oh-my-zsh is initialized."
    exit 1
fi

echo "Installing external plugins and themes for Zsh..."

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

# zsh-autosuggestions plugin
if [ ! -d "$ZSH/custom/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH/custom/plugins/zsh-autosuggestions"
fi

LINK_TARGETS=(
    ".oh-my-zsh:.oh-my-zsh"
    ".zprofile:.zprofile"
    ".zshenv:.zshenv"
    ".zshrc:.zshrc"
    ".ssh/config:.ssh/config"
)

link_file() {
    local src="$1"
    local dest="$2"
    local backup

    if [ ! -e "$src" ]; then
        echo "err: missing source $src"
        exit 1
    fi

    if [ -L "$dest" ] && [ "$(realpath "$dest")" = "$(realpath "$src")" ]; then
        echo "Already linked $dest"
        return
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        backup="$dest.backup.$(date +%Y%m%d%H%M%S)"
        mv "$dest" "$backup"
        echo "Backed up $dest to $backup"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "Linked $dest -> $src"
}

for target in "${LINK_TARGETS[@]}"; do
    src="${target%%:*}"
    dest="${target#*:}"

    link_file "$DOTFILES_DIR/$src" "$HOME/$dest"
done

echo "Shell setup complete!"
