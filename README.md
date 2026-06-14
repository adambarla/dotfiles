# Dotfiles

Personal dotfiles for Unix-like systems.

## Setup

### Full Setup

Clone the repo into `~/dotfiles` and run the setup script:

```sh
git clone --recurse-submodules git@github.com:adambarla/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

The script checks for required tools, initializes submodules, installs zsh theme/plugin dependencies, and links tracked dotfiles into `$HOME`.

### Minimal Shell Setup

To set up just the shell environment (Zsh configurations and SSH config) without Neovim, Tmux, or Himalaya, run:

```sh
git clone --recurse-submodules git@github.com:adambarla/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup_shell.sh
```

### Reverting Changes

To unlink the dotfiles and restore a specific backup of your original configurations, run `./revert.sh` with the backup timestamp as an argument (e.g., `20260614143728`). 

Alternatively, you can automatically restore the most recent backup by passing the `--recent` flag:

```sh
cd ~/dotfiles
./revert.sh --recent
```

If you run the script without arguments, it will show the usage syntax and list all available backup timestamps:

```sh
cd ~/dotfiles
./revert.sh <backup-timestamp> | --recent
```

## Required Tools

For the full setup (`setup.sh`), these commands are expected to be available:

```text
git
nvim
tmux
himalaya
rg
```

On macOS with Homebrew:

```sh
brew install git neovim tmux himalaya ripgrep
```

On Linux, install the equivalent packages with your system package manager. Package names vary, but `neovim`, `tmux`, `git`, and `ripgrep` are common. Install Himalaya from your distro package manager if available, or from the upstream project.

For the minimal setup (`setup_shell.sh`), only `git` is required.

## Linked Paths

`setup.sh` links these paths from `~/dotfiles` into `$HOME` (and `setup_shell.sh` links a subset of these related to the shell and SSH):

```text
.config
.gitconfig
.git-templates
.ideavimrc
.oh-my-zsh
.ssh/config
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

Passwords are not tracked. The current config reads passwords from commands in `config.toml`.

On macOS, add the required iCloud app passwords to Keychain:

```sh
security add-generic-password -a icloud -s himalaya-icloud-imap -w
security add-generic-password -a icloud -s himalaya-icloud-smtp -w
```

On Linux, update `~/.config/himalaya/config.toml` so the `backend.auth.command` and `message.send.backend.auth.command` values read from your preferred secret manager, such as `pass`, `secret-tool`, or `gopass`.

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
