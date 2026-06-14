# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Zsh plugins
plugins=(
    git
    colored-man-pages
    colorize
    pip
    python
    brew
    docker
    zsh-vi-mode
    zsh-syntax-highlighting
    zsh-autosuggestions
    you-should-use
    kubectl
    kubectx
    aws
)

# Append Homebrew completion site-functions to fpath BEFORE sourcing oh-my-zsh
# This ensures they are registered during Oh-My-Zsh's internal compinit call
if [ -d /opt/homebrew/share/zsh/site-functions ]; then
    fpath+=(/opt/homebrew/share/zsh/site-functions)
fi

# Initialize Oh-My-Zsh
source "$ZSH/oh-my-zsh.sh"

# --- User Configurations & Aliases ---

export EDITOR='nvim'
export VISUAL='nvim'

# Python virtual environment activation
alias activate="source .venv/bin/activate"
alias rm="rm -i"

# Tool Configs
export HIMALAYA_CONFIG="$HOME/.config/himalaya/config.toml"

# Gromacs path
if [ -d /usr/local/gromacs/bin ]; then
    export PATH="/usr/local/gromacs/bin:$PATH"
fi

# Docker Desktop integration
[ -f "$HOME/.docker/init-zsh.sh" ] && source "$HOME/.docker/init-zsh.sh" || true

# Conda initialize
if [ -d "$HOME/miniconda3" ]; then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
fi

# SSH Agent setup (only start if not already running)
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    if [ -f "$HOME/.ssh/id_ed25519_dlab" ]; then
        ssh-add "$HOME/.ssh/id_ed25519_dlab" 2>/dev/null
    fi
fi

# FZF fuzzy finder
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Ruby Environment Manager (rbenv)
if command -v rbenv >/dev/null 2>&1; then
    eval "$(rbenv init - zsh)"
fi

# Vi command mode configuration
bindkey -M vicmd '?' history-incremental-search-backward

# Zsh-autosuggestions style color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=250'

# Powerlevel10k configurations (keep at the bottom)
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"
