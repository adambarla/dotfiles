# Dotfiles

Personal macOS dotfiles.

## Setup

Clone the repo into `~/dotfiles` and run the setup script:

```sh
git clone --recurse-submodules git@github.com:adambarla/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

The script checks for required tools, initializes submodules, installs zsh theme/plugin dependencies, and links tracked dotfiles into `$HOME`.

## Required Tools

The setup script expects these commands to be available:

```text
git
nvim
tmux
himalaya
rg
```

With Homebrew:

```sh
brew install git neovim tmux himalaya ripgrep
```

## Linked Paths

`setup.sh` links these paths from `~/dotfiles` into `$HOME`:

```text
.config
.gitconfig
.git-templates
.ideavimrc
.oh-my-zsh
.tmux.conf
.vimrc
.zprofile
.zshenv
.zshrc
```

Existing conflicting paths are backed up with a timestamp. Already-correct symlinks are left unchanged.

## Himalaya

Himalaya uses the tracked config at:

```text
~/.config/himalaya/config.toml
```

Passwords are not tracked. Add the required iCloud app passwords to macOS Keychain:

```sh
security add-generic-password -a icloud -s himalaya-icloud-imap -w
security add-generic-password -a icloud -s himalaya-icloud-smtp -w
```

Then verify:

```sh
himalaya account list
```

## Neovim

Neovim uses `lazy.nvim`. On first launch, the config bootstraps `lazy.nvim` and installs plugins from:

```text
~/.config/nvim/lua/plugins
```

Useful entry points:

```text
Space f f   find files
Space f g   live grep
Space e     file browser
Space m m   open Himalaya mail
```
